class PrintedBook < Book
  def borrow_by(user)
    borrowings.find_by(user: user)
  end

  def borrowed_by?(user)
    !!borrow_by(user)
  end
end
