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

    invoice = extract_data_from_xml(doc)

    if invoice.persisted?
      redirect_to invoice_path(invoice), notice: "Invoice processed successfully."
    else
      flash[:alert] = "There was an error processing the invoice."
      render :new
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def extract_data_from_xml(doc)
    invoice = Invoice.create!(
      series: doc.at_xpath('//nfe:ide/nfe:serie', NAMESPACE)&.text,
      number: doc.at_xpath('//nfe:ide/nfe:nNF', NAMESPACE)&.text,
      emission_date: doc.at_xpath('//nfe:ide/nfe:dhEmi', NAMESPACE)&.text
    )

    Issuer.create!(
      name: doc.at_xpath('//nfe:emit/nfe:xNome', NAMESPACE)&.text,
      cnpj: doc.at_xpath('//nfe:emit/nfe:CNPJ', NAMESPACE)&.text,
      invoice: invoice
    )

    Recipient.create!(
      name: doc.at_xpath('//nfe:dest/nfe:xNome', NAMESPACE)&.text,
      cnpj: doc.at_xpath('//nfe:dest/nfe:CNPJ', NAMESPACE)&.text,
      invoice: invoice
    )

    doc.xpath('//nfe:det', NAMESPACE).each do |product_xml|
      product = Product.create!(
        name: product_xml.at_xpath('nfe:prod/nfe:xProd', NAMESPACE)&.text,
        ncm: product_xml.at_xpath('nfe:prod/nfe:NCM', NAMESPACE)&.text,
        cfop: product_xml.at_xpath('nfe:prod/nfe:CFOP', NAMESPACE)&.text,
        unit: product_xml.at_xpath('nfe:prod/nfe:uCom', NAMESPACE)&.text,
        quantity: product_xml.at_xpath('nfe:prod/nfe:qCom', NAMESPACE)&.text,
        unit_price: product_xml.at_xpath('nfe:prod/nfe:vUnCom', NAMESPACE)&.text,
        invoice: invoice
      )

      Tax.create!(
        icms_value: product_xml.at_xpath('nfe:imposto/nfe:ICMS/nfe:ICMS00/nfe:vICMS', NAMESPACE)&.text,
        ipi_value: product_xml.at_xpath('nfe:imposto/nfe:IPI/nfe:IPITrib/nfe:vIPI', NAMESPACE)&.text,
        product: product
      )
    end

    invoice
  end
end
