$LOAD_PATH.unshift '.'
require 'minitest/autorun'

# Your solutions should go in the `golf.rb` file along side this one
require 'golf'

module GolfTest
  class Hole1Test < Minitest::Test
    def test_multiplies_small_numbers_in_an_array
      assert_equal 24, Golf.hole1([1,2,3,4])
    end

    def test_multiplies_big_numbers_in_an_array
      assert_equal 600, Golf.hole1([5,2,10,6])
    end
  end

  class Hole2Test < Minitest::Test
    def test_fizzbuzz_works_up_to_3
      assert_equal [1, 2, 'fizz'], Golf.hole2(3)
    end

    def test_fizzbuzz_works_up_to_5
      # skip # When you're ready to tackle a test, remove the skip call
      assert_equal [1, 2, 'fizz', 4, 'buzz'], Golf.hole2(5)
    end

    def test_fizzbuzz_works_up_to_15
      assert_equal [1, 2, 'fizz', 4, 'buzz', 'fizz', 7, 8, 'fizz', 'buzz', 11, 'fizz', 13, 14, 'fizzbuzz'], Golf.hole2(15)
    end
  end

  class Hole3Test < Minitest::Test
    def test_caeser_cipher_on_single_character_with_single_shift
      assert_equal 'b', Golf.hole3('a', 1)
    end

    def test_caeser_cipher_on_single_character_with_larger_shift
      assert_equal 'n', Golf.hole3('a', 13)
    end

    def test_caeser_cipher_on_single_character_with_shift_that_wraps
      assert_equal 'f', Golf.hole3('s', 13)
    end

    def test_caesar_cipher_on_short_string
      assert_equal 'khoor', Golf.hole3('hello', 3)
    end

    def test_caesar_cipher_on_mixed_case_string
      assert_equal 'Khoor', Golf.hole3('Hello', 3)
    end

    def test_caesar_cipher_on_longer_string
      assert_equal 'Beli wkuoc wo rkzzi', Golf.hole3('Ruby makes me happy', 10)
    end
  end

  class Hole4Test < Minitest::Test
    def test_roman_numerals_simple
      assert_equal 'I', Golf.hole4(1)
      assert_equal 'II', Golf.hole4(2)
      assert_equal 'III', Golf.hole4(3)
    end

    def test_roman_numerals_round_numbers
      assert_equal 'X', Golf.hole4(10)
      assert_equal 'L', Golf.hole4(50)
      assert_equal 'C', Golf.hole4(100)
      assert_equal 'D', Golf.hole4(500)
      assert_equal 'M', Golf.hole4(1000)
    end

    def test_roman_numerals_less_simple
      assert_equal 'IV', Golf.hole4(4)
      assert_equal 'IX', Golf.hole4(9)
      assert_equal 'XIV', Golf.hole4(14)
      assert_equal 'XX', Golf.hole4(20)
    end

    def test_roman_numerals_very_complex
      assert_equal 'MCMLXXVIII', Golf.hole4(1978)
      assert_equal 'MCMXCIX', Golf.hole4(1999)
    end
  end

  class Hole5Test < Minitest::Test
    def test_evil_numbers_up_to_10
      assert_equal [0, 3, 5, 6, 9, 10], Golf.hole5(10)
    end

    def test_evil_numbers_up_to_50
      assert_equal [
        0, 3, 5, 6, 9, 10, 12, 15, 17,
        18, 20, 23, 24, 27, 29, 30, 33,
        34, 36, 39, 40, 43, 45, 46, 48
      ], Golf.hole5(50)
    end
  end

  class Hole6Test < Minitest::Test
    def test_card_deck_generation
      deck = [
        "AS", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "JS", "QS", "KS",
        "AD", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "JD", "QD", "KD",
        "AH", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "JH", "QH", "KH",
        "AC", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "JC", "QC", "KC",
        "J", "J"
      ]
      assert_equal deck.sort, Golf.hole6.sort
    end
  end
end
