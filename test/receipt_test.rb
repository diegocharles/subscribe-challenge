require_relative 'test_helper'

class ReceiptTest < Minitest::Test
  def setup
    @tax_calculator = TaxCalculator.new
  end

  def test_format_line
    product = Product.new(2, "book", 12.49)
    receipt = Receipt.new([product], @tax_calculator)

    line = receipt.send(:format_line, product, 24.98)
    assert_equal "2 book: 24.98", line
  end

  def test_format_price
    receipt = Receipt.new([], @tax_calculator)

    assert_equal "12.49", receipt.send(:format_price, 12.49)
    assert_equal "12.50", receipt.send(:format_price, 12.5)
    assert_equal "1.50", receipt.send(:format_price, 1.5)
  end

  def test_format_total
    receipt = Receipt.new([], @tax_calculator)

    total_line = receipt.send(:format_total, "Sales Taxes", 1.50)
    assert_equal "Sales Taxes: 1.50", total_line
  end

  def test_line_total_calculation
    product = Product.new(2, "book", 12.49)
    receipt = Receipt.new([product], @tax_calculator)

    # 2 * (12.49 + 0.0 tax) = 24.98
    line_total = receipt.send(:line_total, product, 0.0)
    assert_equal 24.98, line_total
  end

  def test_calculates_totals_correctly
    products = [
      Product.new(1, "music CD", 14.99),
      Product.new(1, "book", 12.49)
    ]
    receipt = Receipt.new(products, @tax_calculator)

    # Capture output
    output = capture_io { receipt.print }.join

    # music CD: 14.99 + 1.50 tax = 16.49
    # book: 12.49 + 0.00 tax = 12.49
    # Total: 16.49 + 12.49 = 28.98
    assert_match(/Sales Taxes: 1\.50/, output)
    assert_match(/Total: 28\.98/, output)
  end
end
