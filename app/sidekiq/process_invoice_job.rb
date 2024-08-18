class ProcessInvoiceJob
  include Sidekiq::Job

  NAMESPACE = { nfe: "http://www.portalfiscal.inf.br/nfe" }

  def perform(xml)
    doc = Nokogiri::XML(xml)

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
  end
end
