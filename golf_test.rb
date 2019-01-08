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
end
