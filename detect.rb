require 'active_support/core_ext/string/filters'

file = File.open("files.txt")

segments = file.read.squish.split(" ")
segments.select! { |segment| segment.include?("/") }

specs, files = segments.partition { |segment| segment.include?("spec") }

folders_to_check = %w(concepts models filters helpers queries services decorators)

files.select! { |file| folders_to_check.any? { |folder| file.include?(folder) } }

files.reject! do |file|
  name_match = file.split("/")[1..-1].join("/").split(".")[0..-2].join("/")
  specs.any? { |spec| spec.include?(name_match) }
end

puts files
