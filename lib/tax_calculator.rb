class TaxCalculator
  def initialize(basic_rate: 0.10, import_rate: 0.05)
    @basic_rate = basic_rate
    @import_rate = import_rate
  end

  def tax_for(product)
    tax = 0
    tax += product.price * @basic_rate unless product.exempt?
    tax += product.price * @import_rate if product.imported?

    round_up(tax)
  end

  private

    def round_up(price)
      ((price / 0.05).ceil * 0.05).round(2)
    end
end
