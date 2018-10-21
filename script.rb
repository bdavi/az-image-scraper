require "open-uri"
require 'csv'

CSV_PATH = "sce_export.csv"
EXPORT_PATH = "saved_images"

images = []
count = 0
CSV.foreach(CSV_PATH, row_sep: :auto, headers: true) do |row|
  images << {
    url: row[28],
    part_number: row[155].gsub("@", "")
  }
  count += 1
  break if count > 10
end

images.each_with_index do |image, i|
  file_extension = image[:url].split(".").last
  File.open("#{EXPORT_PATH}/#{image[:part_number]}.#{file_extension}", 'wb') do |f|
    f.write open(image[:url]).read
  end
  puts "Downloaded image ##{i}: #{image[:part_number]}.#{file_extension}"
  puts "    From #{image[:url]}"
end
