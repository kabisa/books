# This class keeps track of the subclasses for Book
class BookType <  Array
  TYPES = [Ebook, PrintedBook]

  class << self
    # @return [Array<Constant>] a list with subclasses of Book
    def types
      new.types
    end

    # 'converts' a string into a classname
    # @param camel_cased_word [String]
    # @return the corresponding classname or
    # Book if `camel_cased_word` does not match one of the Book's subclasses
    def book_class(camel_cased_word)
      constant = camel_cased_word.safe_constantize

      types.include?(constant) ? constant : Book
    end
  end

  # @return [Array<Constant>] a list with subclasses of Book
  def types
    self.class.new(TYPES)
  end

  # @return [Array<Symbol>] a list with subclasses as symbols of Book
  def to_sym
    to_s.map(&:to_sym)
  end

  private
    def to_s
      types.map(&:to_s)
    end
end
