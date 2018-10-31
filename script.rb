require "open-uri"
require 'csv'

CSV_PATH = "sce_export.csv"
EXPORT_PATH = "saved_images"

images = []

CSV.foreach(CSV_PATH, row_sep: :auto, headers: true) do |row|
  urls = row[28].split(",")
  part_number = row[155].gsub("@", "")
  urls.each_with_index do |url, index|
    filename = part_number + (index == 0 ? "" : "-" + (index + 1).to_s)
    file_extension = url.split(".").last
    File.open("#{EXPORT_PATH}/#{filename}.#{file_extension}", 'wb') do |f|
      f.write open(url).read
    end
    puts "Downloaded image: #{part_number}.#{file_extension}"
    puts "    From #{url}"
  end
end

