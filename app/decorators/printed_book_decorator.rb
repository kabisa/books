class PrintedBookDecorator < BookDecorator
  def available_copies
    h.pluralize(copies_count - borrowings_count, Copy.model_name.human.downcase)
  end
end
