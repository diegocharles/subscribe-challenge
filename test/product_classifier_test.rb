require_relative 'test_helper'

class ProductClassifierTest < Minitest::Test
  def test_detects_book_as_exempt
    assert ProductClassifier.exempt?("book")
    assert ProductClassifier.exempt?("books")
    assert ProductClassifier.exempt?("2 book")
    assert ProductClassifier.exempt?("book of spells")
  end

  def test_detects_chocolate_as_exempt
    assert ProductClassifier.exempt?("chocolate")
    assert ProductClassifier.exempt?("chocolates")
    assert ProductClassifier.exempt?("chocolate bar")
    assert ProductClassifier.exempt?("box of chocolates")
  end

  def test_detects_pill_as_exempt
    assert ProductClassifier.exempt?("pill")
    assert ProductClassifier.exempt?("pills")
    assert ProductClassifier.exempt?("headache pills")
    assert ProductClassifier.exempt?("packet of headache pills")
  end

  def test_detects_non_exempt_products
    refute ProductClassifier.exempt?("music CD")
    refute ProductClassifier.exempt?("perfume")
    refute ProductClassifier.exempt?("bottle of perfume")
  end

  def test_case_insensitive
    assert ProductClassifier.exempt?("BOOK")
    assert ProductClassifier.exempt?("Chocolate")
    assert ProductClassifier.exempt?("PILLS")
  end
end
