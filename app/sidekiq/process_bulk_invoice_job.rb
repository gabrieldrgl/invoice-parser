require "zip"

class ProcessBulkInvoiceJob
  include Sidekiq::Job

  def perform(file_path)
    Zip::File.open(file_path) do |zipfile|
      zipfile.each { |entry| ProcessInvoiceJob.perform_async(entry.get_input_stream.read) }
    end
  end
end
