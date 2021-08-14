# frozen_string_literal: true

require "yaml"

# List files in a directory
module FileOperations
  def find_files(directory)
    Dir.entries(directory).sort[2..-1]
  end

  def list_files(entries)
    puts "\n(#)  File name\n\n"
    entries.each_with_index do |file, index|
      puts "(#{index + 1})   #{file}\n\n"
    end
  end

  def load_yaml(filename)
    YAML.load(File.read(filename))
  end
end
