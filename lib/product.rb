require_relative 'product_classifier'

class Product
  attr_reader :quantity, :name, :price

  def initialize(quantity, name, price, classifier: ProductClassifier)
    @quantity = quantity
    @name = name
    @price = price
    @classifier = classifier
  end

  def imported?
    name.include?("imported")
  end

  def exempt?
    @classifier.exempt?(name)
  end
end
