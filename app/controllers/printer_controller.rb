class PrinterController < ApplicationController

  def print
    params.require(:ticket_type)
    params.require(:id)

    printer = FiscalPrinter.new(params)

    
    begin
      config = YAML.load_file("#{Rails.root}/config/printer.yml")
      data = config["fiscal"].symbolize_keys!
      
      RubyPython.start
      epson = RubyPython.import("pyfiscalprinter.controlador")
      conn = epson.EpsonPrinter.new("COM2")
      
      unless conn.nil?
        res = conn.openBillTicket(params[:ticket_type],
          params[:customer_name], params[:customer_address],
          params[:customer_doc_nbr], params[:customer_doc_type], params[:iva_type])
        
        @ticket.item_tickets.each do |it|
          item = it.item
          conn.addItem(item.description, it.quantity, item.price, iva, discount, discount_desc)
        end

        conn.addPayment(payment_desc, payment)

        conn.closeDocument.rubify
        conn.close
        RubyPython.stop

        render :show, notice: "Se envio a la impresora"
      else
        RubyPython.stop
        @ticket.errors.add(:impresora, "No se pudo conectar a la impresora")
        render :show
      end

    rescue => ex
      conn.close unless conn.nil?
      RubyPython.stop
      @ticket.errors.add(:impresora, ex.message)
      render :show
    end
  end

  def close_day
    RubyPython.start
    epson = RubyPython.import("pyfiscalprinter.controlador")
    conn = epson.EpsonPrinter.new("COM2")
    
    if conn.nil?
      RubyPython.stop
    else
      conn.dailyClose('Z')
      conn.close
      RubyPython.stop
    end
  end

end