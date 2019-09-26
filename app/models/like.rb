class Like < Vote
  belongs_to :book, counter_cache: true

end
