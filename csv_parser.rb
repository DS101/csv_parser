require 'csv'
require 'byebug'

MODELS = ["ПЭТД", "ПЭТВ", "ПуГВ", "АПБ"]
COLORS = ["зеленый-желтый"]

arr = Array.new

CSV.read("11.csv", encoding: "UTF-8", headers: true).each_with_index do |row, i|
  data = Hash.new
  data[:cold_resistant] = true if row.to_s.match?(/-ХЛ\s/i)
  data[:merk] = MODELS.find { |model| row.to_s.match?(/#{model}/i) }
  data[:merk] = data[:merk] + "-ХЛ" if data[:cold_resistant] && data[:merk]
  data[:color] = COLORS.find { |color| row.to_s.match?(/#{color}/i) }
  data[:desc_from_file] = row.to_s.split(";").map(&:strip)[0]
  data[:unit] = row.to_s.split(";").map(&:strip)[1]
  data[:quantity] = row.to_s.split(";").map(&:strip)[2]
  arr << data
end
byebug
arr
