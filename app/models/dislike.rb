class Dislike < Vote
  belongs_to :book, counter_cache: true

end
