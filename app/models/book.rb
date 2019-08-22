class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }

  class << self
    def types
      [Ebook, PrintedBook]
    end

    def type_strings
      types.map(&:to_s)
    end

    def type_symbols
      type_strings.map(&:to_sym)
    end

    def policy_class
      BookPolicy
    end

    def constantize(camel_cased_word)
      constant = camel_cased_word.safe_constantize

      types.include?(constant) ? constant : name.constantize
    end
  end
end
