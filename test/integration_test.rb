require_relative 'test_helper'

class IntegrationTest < Minitest::Test
  def setup
    @tax_calculator = TaxCalculator.new
  end

  def test_input_1
    input = [
      "2 book at 12.49",
      "1 music CD at 14.99",
      "1 chocolate bar at 0.85"
    ]

    products = input.map { |line| ReceiptLineParser.parse_line(line) }
    receipt = Receipt.new(products, @tax_calculator)

    output = capture_io { receipt.print }.join

    assert_match(/2 book: 24\.98/, output)
    assert_match(/1 music CD: 16\.49/, output)
    assert_match(/1 chocolate bar: 0\.85/, output)
    assert_match(/Sales Taxes: 1\.50/, output)
    assert_match(/Total: 42\.32/, output)
  end

  def test_input_2
    input = [
      "1 imported box of chocolates at 10.00",
      "1 imported bottle of perfume at 47.50"
    ]

    products = input.map { |line| ReceiptLineParser.parse_line(line) }
    receipt = Receipt.new(products, @tax_calculator)

    output = capture_io { receipt.print }.join

    assert_match(/1 imported box of chocolates: 10\.50/, output)
    assert_match(/1 imported bottle of perfume: 54\.65/, output)
    assert_match(/Sales Taxes: 7\.65/, output)
    assert_match(/Total: 65\.15/, output)
  end

  def test_input_3
    input = [
      "1 imported bottle of perfume at 27.99",
      "1 bottle of perfume at 18.99",
      "1 packet of headache pills at 9.75",
      "3 imported boxes of chocolates at 11.25"
    ]

    products = input.map { |line| ReceiptLineParser.parse_line(line) }
    receipt = Receipt.new(products, @tax_calculator)

    output = capture_io { receipt.print }.join

    assert_match(/1 imported bottle of perfume: 32\.19/, output)
    assert_match(/1 bottle of perfume: 20\.89/, output)
    assert_match(/1 packet of headache pills: 9\.75/, output)
    assert_match(/3 imported boxes of chocolates: 35\.55/, output)
    assert_match(/Sales Taxes: 7\.90/, output)
    assert_match(/Total: 98\.38/, output)
  end
end
