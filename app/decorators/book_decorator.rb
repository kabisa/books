class BookDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def formatted_type
    I18n.t(object.type, scope: 'book_types')
  end

  def dom_id(prefix = nil)
    h.dom_id(object, prefix)
  end
end
