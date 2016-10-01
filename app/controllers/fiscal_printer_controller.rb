class FiscalPrinterController < ApplicationController

  def print
    params.require(:ticket_id)
    @ticket = Ticket.find(params[:ticket_id])

    printer = FiscalPrinter.new
    printer.set_data(@ticket, ticket_params)

    printer.print

    resp = if printer.errors
      { alert: "Error con la impresora: #{printer.errors}" }
    else
      { notice: 'Se envio a la impresora con exito' }
    end

    redirect_to @ticket, resp
  end

  def close_day
    printer = FiscalPrinter.new
    printer.close_day
  end

  private

  def ticket_params
    params.require(:payment).permit(:ticket_type, :iva, :iva_type, :customer_name, :customer_address,:customer_doc_nbr, :customer_doc_type)
  end
end
