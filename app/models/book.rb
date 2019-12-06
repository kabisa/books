class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :num_of_pages, numericality: { greater_than: 0 }, allow_nil: true
  validates :summary, length: { maximum: 2048 }

  has_many :votes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Though `copies` is a PrintedBook attribute, we define it in the base class
  # so we can render a proper form.
  has_many :copies, dependent: :destroy do
    def borrowables
      proxy_association.owner.copies.filter(&:'borrowable?')
    end
  end
  has_and_belongs_to_many :writers

  accepts_nested_attributes_for :copies, allow_destroy: true
  acts_as_paranoid
  acts_as_taggable
  mount_uploader :cover, CoverUploader
  before_validation :set_writers

  class << self
    def policy_class
      BookPolicy
    end
  end

  # Currently there's no need to define a view partial for both e-book and printed book
  # so in both cases we use the same partial.
  # This may change is the future.
  def to_partial_path
    'books/book'
  end

  def to_s
    title.inspect
  end

  def writer_names
    @writer_names ||= writers.map(&:name)
  end

  def writer_names=(value)
    begin
      @writer_names = parse_tagify_json(value)
    rescue
      @writer_names = value.split(/,\s*/)
    end
  end

  def tag_list=(value)
    begin
      arr = parse_tagify_json(value)
      super(arr)
    rescue
      super
    end
  end

  private

  def parse_tagify_json(value)
    JSON.parse(value).map { |h| h['value'] }
  end

  def set_writers
    return if @writer_names.nil?

    self.writers = @writer_names.map do |name|
      writer = Writer.find_or_initialize_by(name: name)

      if writer.valid?
        writer
      else
        errors.add(:writer_names, :invalid)
        return nil
      end
    end
  end
end
