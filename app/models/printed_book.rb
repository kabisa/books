class PrintedBook < Book
  validates :copies, presence: true # At least 1 copy is required

  def copies_count
    copies.sum(:number)
  end
end
