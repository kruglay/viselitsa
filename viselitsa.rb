# encoding: utf-8

# Популярная детская игра, Виселица
# https://ru.wikipedia.org/wiki/Виселица_(игра)

require_relative 'lib/game.rb'
require_relative 'lib/result_printer.rb'
require_relative 'lib/word_reader.rb'

# Записываем версию игры в константу VERSION
VERSION = 'Игра виселица, версия 4. (c) Хороший программист\n'

# Создаем экземпляр класса WordReader
word_reader = WordReader.new
words_file_name = "#{File.dirname(__FILE__)}/data/words.txt"
word = word_reader.read_from_file(words_file_name)

# Создаем игру и прописываем ее версию с помощью сеттера version=
game = Game.new(word)
game.version = VERSION

# Теперь экземпляр ResultPrinter-а нельзя создать без игры
# Именно поэтому порядо создания методов именно такой
printer = ResultPrinter.new(game)

# Основной игровой цикл остался прежним
while game.in_progress? do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
