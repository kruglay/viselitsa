# encoding: utf-8

# Класс, отвечающий за чтение слова для игры

class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    return nil unless File.exist?(file_name)
    File.readlines(file_name).sample.chomp
  end
end
