class ReceiptLineParser
  def self.parse_line(line)
    quantity, rest_of_line = line.split(" ", 2)
    name, price = rest_of_line.split(" at ")
    Product.new(quantity.to_i, name.strip, price.to_f)
  end
end
