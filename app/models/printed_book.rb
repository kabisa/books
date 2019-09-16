class PrintedBook < Book
  has_many :borrowings, through: :copies

  validates :copies, presence: true # At least 1 copy is required

  def copies_count
    copies.sum(&:number)
  end

  def borrowings_count
    borrowings.count
  end

  def borrow_by(user)
    borrowings.find_by(user: user)
  end

  def borrowed_by?(user)
    !!borrow_by(user)
  end
end
