class FiscalPrinter
  
  def initalize(params)
    @iva           = (params[:iva] || 21.00).to_f
    @discount      = (params[:discount] || 0).to_f
    @discount_desc =  params[:discount_desc] || ""
    @payment_desc  =  params[:payment_desc] || "Cierre Ticket"
    @payment       = (params[:payment] || 0).to_f

  end

  def print_ticket(id)
    @ticket = Ticket.find(id)
    
  end

  def add_item
    
  end

  def close_day
    
  end
end