require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'

class NightReadTest < Minitest::Test

  def test_it_exists
    nr = NightRead.new

    assert_instance_of NightRead, nr
  end

  def test_it_can_split_lines
    skip # need to add runner method
    nr = NightRead.new
    expected_1 = "..0.0.0.0.0......00.0.0.00..0..0"
    expected_2 = "..00.00.0..0....00.0000..0..000."
    braille = "..0.0.0.0.0......00.0.0.00..0..0\n..00.00.0..0....00.0000..0..000.\n.0....0.0.0....0.00.0.0........."
    nr.parse_braille_lines(braille)
    assert_equal expected_1, nr.line_1
    assert_equal expected_2, nr.line_2
  end

  def test_it_can_split_braille_into_chunks
    nr = NightRead.new
    expected_1 = ['..','0.', '0.', '0.', '0.', '0.', '..', '..', '.0', '0.', '0.','0.', '00', '..', '0.','.0']
    expected_2 = ['.0', '..', '..', '0.', '0.', '0.','..', '.0', '.0', '0.', '0.', '0.', '..', '..', '..','..']

    braille = "..0.0.0.0.0......00.0.0.00..0..0\n..00.00.0..0....00.0000..0..000.\n.0....0.0.0....0.00.0.0........."
    nr.parse_braille_lines(braille)
    assert_equal expected_1, nr.line_1_braille
    assert_equal expected_2, nr.line_3_braille
  end

  def test_format_braille_keys
    nr = NightRead.new
    expected = [["..", "..", ".0"], ["0.", "00", ".."], ["0.", ".0", ".."], ["0.", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", "0."], ["..", "..", ".."], ["..", "..", ".0"], [".0", "00", ".0"], ["0.", ".0", "0."], ["0.", "00", "0."], ["0.", "0.", "0."], ["00", ".0", ".."], ["..", "..", ".."], ["0.", "00", ".."], [".0", "0.", ".."]]
    braille = "..0.0.0.0.0......00.0.0.00..0..0\n..00.00.0..0....00.0000..0..000.\n.0....0.0.0....0.00.0.0........."
    nr.parse_braille_lines(braille)
    assert_equal expected, nr.braille_letters
  end

  def test_translate_to_english
    nr = NightRead.new

    braille = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n....................................\n...................................."
    nr.parse_braille_lines(braille)
    assert_equal "aaaaaaaaaaaaaaaaaa", nr.translate_to_english
  end




end
