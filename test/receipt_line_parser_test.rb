require_relative 'test_helper'

class ReceiptLineParserTest < Minitest::Test
  def test_parses_simple_line
    product = ReceiptLineParser.parse_line("1 book at 12.49")

    assert_equal 1, product.quantity
    assert_equal "book", product.name
    assert_equal 12.49, product.price
  end

  def test_parses_line_with_multiple_words
    product = ReceiptLineParser.parse_line("1 music CD at 14.99")

    assert_equal 1, product.quantity
    assert_equal "music CD", product.name
    assert_equal 14.99, product.price
  end

  def test_parses_line_with_imported_product
    product = ReceiptLineParser.parse_line("1 imported bottle of perfume at 47.50")

    assert_equal 1, product.quantity
    assert_equal "imported bottle of perfume", product.name
    assert_equal 47.50, product.price
  end

  def test_parses_line_with_quantity_greater_than_one
    product = ReceiptLineParser.parse_line("3 imported boxes of chocolates at 11.25")

    assert_equal 3, product.quantity
    assert_equal "imported boxes of chocolates", product.name
    assert_equal 11.25, product.price
  end

  def test_strips_whitespace_from_name
    product = ReceiptLineParser.parse_line("1  book  at 12.49")

    assert_equal "book", product.name
  end
end
