class ProductClassifier
  EXEMPT_WORDS = %w[book chocolate pill].freeze

  def self.exempt?(product_name)
    name_lower = product_name.downcase
    # Ignore plurals. Eg: "pills" -> "pill", "books" -> "book"
    EXEMPT_WORDS.any? { |word| name_lower.include?(word) }
  end
end
