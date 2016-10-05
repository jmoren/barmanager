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

    resp = if printer.errors
      { alert: "Error con la impresora: #{printer.errors}" }
    else
      { notice: 'Se realizo el cierre con exito' }
    end

    redirect_to close_day_path, resp
  end

  def close_shift
    shift = Shift.find(params[:shift_id])
    resp  = ""
    printer = FiscalPrinter.new
    printer.close_shift

    if printer.errors
      resp = { alert: "Error con la impresora: #{printer.errors}" }
    else
      shift.update(fiscal_printed: true)
      resp = { notice: 'Se realizo el cierre con exito' }
    end

    redirect_to shifts_path, resp
  end

  private

  def ticket_params
    params.require(:payment).permit(:ticket_type, :iva, :iva_type, :customer_name, :customer_address,:customer_doc_nbr, :customer_doc_type)
  end
end
