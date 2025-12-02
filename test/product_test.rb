require_relative 'test_helper'

class ProductTest < Minitest::Test
  def test_initialization
    product = Product.new(2, "book", 12.49)

    assert_equal 2, product.quantity
    assert_equal "book", product.name
    assert_equal 12.49, product.price
  end

  def test_imported_detection
    imported_product = Product.new(1, "imported bottle of perfume", 47.50)
    regular_product = Product.new(1, "bottle of perfume", 18.99)

    assert imported_product.imported?
    refute regular_product.imported?
  end

  def test_exempt_delegates_to_classifier
    exempt_product = Product.new(1, "book", 12.49)
    non_exempt_product = Product.new(1, "music CD", 14.99)

    assert exempt_product.exempt?
    refute non_exempt_product.exempt?
  end

  def test_exempt_with_plural
    product = Product.new(1, "headache pills", 9.75)
    assert product.exempt?
  end
end
