# encoding: utf-8

# Популярная детская игра, версия 3 - с чтением данных из внешних файлов
# https://ru.wikipedia.org/wiki/Виселица_(игра)

current_path = "./" + File.dirname(__FILE__)

require current_path + "/lib/game.rb"
require current_path + "/lib/result_printer.rb"
require current_path + "/lib/word_reader.rb"

puts "Игра виселица. Версия 4. C чтением данных из файлов.\n\n(c) 2016 Хороший программист\n\n"

words_file_name = current_path + "/data/words.txt"
word_reader = WordReader.new
word = word_reader.read_from_file(words_file_name)

game = Game.new(word)
game.version = 4.0

printer = ResultPrinter.new(game)

while game.in_progress? do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
