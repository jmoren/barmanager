class FiscalPrinter

  attr_accessor :ticket_type, :errors, :iva, :iva_type, :discount, :total, :discount_desc, :payment_desc, :ticket, :config, :customer

  def initialize
    @config =  YAML.load_file("#{Rails.root}/config/printer.yml")["fiscal"].symbolize_keys!
  end

  def create_connection
    epson = RubyPython.import("pyfiscalprinter.controlador")
    epson.EpsonPrinter.new(config[:port])
  end

  def close_day
    RubyPython.start
    begin
      conn = create_connection

      unless conn.nil?
        conn.dailyClose('Z')
      end

      conn.close
    rescue => e
      conn.close if conn
      self.errors = e.message
    end
    RubyPython.stop
  end

  def close_shift
    RubyPython.start
    begin
      conn = create_connection

      unless conn.nil?
        conn.dailyClose('X')
      end
      
      conn.close
    rescue => e
      conn.close if conn
      self.errors = e.message
    end
    RubyPython.stop
  end

  def set_data(ticket, options)
    @ticket        = ticket
    @iva           = options.fetch(:iva,21.0).to_f
    @iva_type      = options.fetch(:iva_type, 'C')
    @discount      = options.fetch(:discount, 0.0).to_f
    @total         = options.fetch(:total, ticket.total).to_f
    @discount_desc = options.fetch(:discount_desc, "**")
    @payment_desc  = options.fetch(:payment_desc, "Cierre Ticket")
    @ticket_type   = options.fetch(:ticket_type, 'B')
    @customer = {
      name: options[:customer_name], address: options[:customer_address],
      doc_type: options[:customer_doc_type], doc_number: options[:customer_doc_nbr]
    }
  end

  def print
    RubyPython.start
    begin
      conn = create_connection

      conn.openBillTicket(ticket_type, customer[:name], customer[:address],
          customer[:doc_number], customer[:doc_type], iva_type)

      ticket.item_tickets.each do |it|
        item = it.item
        conn.addItem(item.description, it.quantity, item.price, iva, discount, discount_desc)
      end

      conn.addPayment(payment_desc, total)

      conn.closeDocument.rubify
      conn.close
    rescue => ex
      conn.close if conn
      self.errors = ex.message
    end

    RubyPython.stop
  end
end
