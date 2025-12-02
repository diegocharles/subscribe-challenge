require_relative 'test_helper'

class TaxCalculatorTest < Minitest::Test
  def setup
    @calculator = TaxCalculator.new
  end

  def test_basic_tax_for_non_exempt_product
    product = Product.new(1, "music CD", 14.99)
    tax = @calculator.tax_for(product)

    # 14.99 * 0.10 = 1.499, rounded up to 1.50
    assert_equal 1.50, tax
  end

  def test_no_basic_tax_for_exempt_product
    product = Product.new(1, "book", 12.49)
    tax = @calculator.tax_for(product)

    assert_equal 0.0, tax
  end

  def test_import_tax_for_imported_product
    product = Product.new(1, "imported box of chocolates", 10.00)
    tax = @calculator.tax_for(product)

    # 10.00 * 0.05 = 0.50
    assert_equal 0.50, tax
  end

  def test_import_tax_for_imported_exempt_product
    product = Product.new(1, "imported box of chocolates", 10.00)
    tax = @calculator.tax_for(product)

    # Only import tax, no basic tax (exempt)
    # 10.00 * 0.05 = 0.50
    assert_equal 0.50, tax
  end

  def test_combined_taxes_for_imported_non_exempt
    product = Product.new(1, "imported bottle of perfume", 47.50)
    tax = @calculator.tax_for(product)

    # Basic: 47.50 * 0.10 = 4.75
    # Import: 47.50 * 0.05 = 2.375, rounded up to 2.40
    # Total: 4.75 + 2.40 = 7.15
    assert_equal 7.15, tax
  end

  def test_rounding_up_to_nearest_005
    # Test case: 1.499 should round to 1.50
    product = Product.new(1, "music CD", 14.99)
    tax = @calculator.tax_for(product)

    assert_equal 1.50, tax
  end

  def test_rounding_up_edge_cases
    # Test case: 2.375 should round to 2.40 (not 2.35)
    product = Product.new(1, "imported bottle of perfume", 27.99)
    tax = @calculator.tax_for(product)

    # Basic: 27.99 * 0.10 = 2.799, rounded to 2.80
    # Import: 27.99 * 0.05 = 1.3995, rounded to 1.40
    # Total: 2.80 + 1.40 = 4.20
    assert_equal 4.20, tax
  end
end
