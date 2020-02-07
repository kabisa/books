class Book < ApplicationRecord
  include SortByNullsLast

  # [1]
  #
  # associations:
  #
  has_many :votes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :copies, dependent: :destroy do
    def borrowables
      proxy_association.owner.copies.filter(&:'borrowable?')
    end
  end
  has_many :borrowings, through: :copies
  has_and_belongs_to_many :writers

  belongs_to :reedition, optional: true, class_name: 'Book'

  delegate :title, to: :reedition, prefix: true, allow_nil: true

  # validations:
  #
  validates :title, presence: true, length: { maximum: 255 }
  validates :link, length: { maximum: 2048 }, url: true
  validates :num_of_pages, numericality: { greater_than: 0, less_than: 2**15 }, allow_nil: true # [2]
  validates :summary, length: { maximum: 2048 }
  validate :at_least_one_medium_is_required

  before_validation :set_writers

  accepts_nested_attributes_for :copies, allow_destroy: true

  # scopes:
  #
  # `complement_with` extends the collection returned by the current
  # scope with the collection that satifies `opts`.
  # This allows you to add specific items to a complex query that
  # contains `joins`, `order` or other operations.
  scope :complement_with, ->(opts) { self.or(unscope(:where).rewhere(opts)) }
  sort_by_nulls_last :num_of_pages, :published_on

  acts_as_paranoid
  acts_as_taggable
  mount_uploader :cover, CoverUploader

  ransacker :published_years_ago, formatter: -> (v) { v.to_i.year.ago }, type: :integer do |parent|
    parent.table[:published_on]
  end

  def to_s
    title.inspect
  end

  def copies_count
    copies.sum(&:number)
  end

  def borrowings_count
    borrowings.count
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

  def borrow_by(user)
    borrowings.find_by(user: user)
  end

  def borrowed_by?(user)
    !!borrow_by(user)
  end

  private

  def at_least_one_medium_is_required
    # At this in the validation process a book still has copies,
    # so `copies.empty?` is `false`.
    # Instead we can use the `marked_for_destruction?` attribute
    # to check if the user has removed all copies.
    # See also: https://boonedocks.net/blog/2011/01/29/Rails-validations-with-accepts_nested_attributes_for-and-_destroy.html
    if copies.all?(&:marked_for_destruction?) && link.blank?
      self.copies = Copy.none
      errors.add(:link, :blank)
    end
  end

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

# [1] see https://rails.rubystyle.guide/
# [2] `num_of_pages` is a signed int of 2 bytes
