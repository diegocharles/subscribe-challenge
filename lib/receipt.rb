class Receipt
  def initialize(items, tax_calculator)
    @items = items
    @tax_calculator = tax_calculator
  end

  def print
    total_tax = 0
    total = 0

    @items.each do |product|
      tax = @tax_calculator.tax_for(product)
      line_total = line_total(product, tax)

      total_tax += tax * product.quantity
      total += line_total

      puts format_line(product, line_total)
    end

    puts format_total("Sales Taxes", total_tax)
    puts format_total("Total", total)
  end

  private

  def line_total(product, tax)
    product.quantity * (product.price + tax)
  end

  def format_line(product, total)
    "#{product.quantity} #{product.name}: #{format_price(total)}"
  end

  def format_total(label, amount)
    "#{label}: #{format_price(amount)}"
  end

  def format_price(amount)
    format("%.2f", amount)
  end
end
