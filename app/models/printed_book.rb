class PrintedBook < Book

  def copies_count
    copies.sum(:number)
  end
end
