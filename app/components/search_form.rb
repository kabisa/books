class SearchForm < ActionView::Component::Base
  include Ransack::Helpers::FormHelper

  def initialize(q:)
    @q = q
  end

  private

  attr_reader :q
end

