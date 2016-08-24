# encoding: utf-8

# Основной класс игры. Хранит состояние игры и предоставляет функции
# для развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.)
#
# С поддержко русских букв в верхнем и нижнем регистрах

# Подключаем библиотеку для обработки (в т.ч.) русских строк
require 'unicode'

class Game
  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = :in_progress
  end

  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Задано пустое слово, не о чем играть. Закрываемся."
    else
      slovo = slovo.encode("UTF-8")
    end

    Unicode.upcase(slovo).split('')
  end

  def status
    @status
  end

  def is_good?(letter)
    @letters.include?(letter) ||
      (letter == "Е" && @letters.include?("Ё")) ||
      (letter == "Ё" && @letters.include?("Е")) ||
      (letter == "И" && @letters.include?("Й")) ||
      (letter == "Й" && @letters.include?("И"))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when 'И' then letters << 'Й'
    when 'Й' then letters << 'И'
    when 'Е' then letters << 'Ё'
    when 'Ё' then letters << 'Е'
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def lost?
    @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def next_step(letter)
    letter = Unicode.upcase(letter)

    return if @status == :won || @status == :lost
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)

      @errors += 1

      @status = :lost if lost?
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""

    while letter == "" do
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
