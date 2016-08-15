# encoding: utf-8

# Класса, отвечающий за ввод данных в программу "виселица"

class WordReader
  def read_from_args
    return ARGV[0]
  end

  def read_from_file(file_name)
    if !File.exist?(file_name)
      return nil
    end

    f = File.new(file_name, "r:UTF-8")
    lines = f.readlines
    f.close

    return lines.sample.chomp
  end
end
