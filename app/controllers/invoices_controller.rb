class InvoicesController < ApplicationController
  before_action :authenticate_user!

  NAMESPACE = { nfe: "http://www.portalfiscal.inf.br/nfe" }

  def index
    @invoices = Invoice.where("number LIKE ?", "%#{params[:filter]}%").all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    uploaded_file = params[:file]

    if uploaded_file.content_type == "application/xml" || uploaded_file.content_type == "text/xml"
      process_xml(uploaded_file)
    elsif uploaded_file.content_type == "application/zip"
      process_zip(uploaded_file)
    else
      flash[:error] = "Tipo de arquivo não suportado."
      redirect_to new_invoice_path
    end

    redirect_to invoices_path, notice: "Invoice processing started. You will be notified when it is done."
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def process_xml(file)
    xml_content = file.read

    ProcessInvoiceJob.perform_async(xml_content)
    flash[:success] = "Arquivo XML processado com sucesso."
  end

  def process_zip(file)
    temp_file_path = Rails.root.join("tmp", file.original_filename)
    File.open(temp_file_path, "wb") do |f|
      f.write(file.read)
    end

    # Passa o caminho do arquivo para o job do Sidekiq
    ProcessBulkInvoiceJob.perform_async(temp_file_path.to_s)
    flash[:success] = "Arquivo ZIP processado com sucesso."
  end
end
