require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

require "./pokemon"

class TestSecretGenerator < Minitest::Test
  def code(name, trainer_id, cash)
    SecretGenerator.new(name:, cash:, trainer_id:).secret_code
  end

  def setup
  end

  def test_names_over_5_characters
    assert_equal code("ASH Ketchum", 45772, 3000), code("ASH K", 45772, 3000)
  end

  def test_cash_value_under_16_bits
    assert_equal "00986", code("ASH", 45772, 3000)
  end

  # If cash value is over 16 bits it returns cash mod 16 bit max
  def test_cash_value_over_16_bits
    assert_equal "01166", code("ASH", 45772, 300000)
  end

  # If trainer_id value is over 16 bits, decrement with cash
  def test_cash_value_over_16_bits
    assert_equal "00881", code("ASH", 75772, 3000)
  end

  # If trainer_id value is over 16 bits and cash is 0, use max
  def test_cash_value_over_16_bits_no_cash
    assert_equal "00919", code("ASH", 75772, 0)
  end
end
