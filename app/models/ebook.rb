class Ebook < Book
  validates :link, presence: true,
    length: { maximum: 2048 },
    url: true

end
