require_relative 'lib/product'
require_relative 'lib/receipt_line_parser'
require_relative 'lib/tax_calculator'
require_relative 'lib/receipt'

input = ARGF.readlines.map(&:strip).reject(&:empty?)
items = input.map { |line| ReceiptLineParser.parse_line(line) }

receipt = Receipt.new(items, TaxCalculator.new)
receipt.print
