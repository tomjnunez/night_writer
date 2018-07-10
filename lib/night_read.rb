require_relative 'file_io'
require_relative 'braille_hash'

class NightRead
  include BrailleHash
  attr_reader :braille_letters, :file_io, :english, :english_letters
  attr_accessor :line_1, :line_2, :line_3, :line_1_braille, :line_2_braille, :line_3_braille

  def initialize
    @file_io = FileIO.new
    @braille_to_alpha = BrailleHash.braille_hash.invert
    @line_1 = []
    @line_2 = []
    @line_3 = []
    @line_1_braille = []
    @line_2_braille = []
    @line_3_braille = []
    @braille_letters = []
    @english_letters = []
  end

  def encode_file_to_english
    braille = file_io.read
    @english = encode_to_english(braille)
    file_io.write(english)
  end

  def encode_to_english(input)
    parsed = parse_braille_lines(input)
    letters_in_braille = format_braille_keys(parsed)
    letters_in_english = translate_to_english(letters_in_braille)
    capitalize(letters_in_english)
  end

  def parse_braille_lines(input)
    @line_1, @line_2, @line_3 = input.split("\n")
  end

  def format_braille_keys(parsed)
    @line_1_braille = line_1.scan(/../)
    @line_2_braille = line_2.scan(/../)
    @line_3_braille = line_3.scan(/../)
    index = 0
    until index > line_1_braille.length - 1
      @braille_letters << [line_1_braille[index], line_2_braille[index], line_3_braille[index]]
      index +=1
    end
    return @braille_letters
  end

  def translate_to_english(letters_in_braille)
    @braille_letters.map do |letter|
      @braille_to_alpha[letter]
    end
  end

  def capitalize(letters_in_english)
    letters_in_english.map.with_index do |letter, index|
      if letter == "caps"
        letter = letters_in_english[index + 1].upcase
        letters_in_english.delete_at(index + 1)
        letter
      else
        letter
      end
    end.join
  end
end
