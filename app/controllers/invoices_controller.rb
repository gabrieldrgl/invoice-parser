class InvoicesController < ApplicationController
  NAMESPACE = { nfe: "http://www.portalfiscal.inf.br/nfe" }

  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    uploaded_file = params[:file]
    xml_content = uploaded_file.read
    doc = Nokogiri::XML(xml_content)

    ProcessInvoiceJob.perform_async(xml_content)

    redirect_to invoices_path, notice: "Invoice processing started. You will be notified when it is done."
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
