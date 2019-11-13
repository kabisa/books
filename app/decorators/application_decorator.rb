class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end
  def dom_id(prefix = nil)
    h.dom_id(object, prefix)
  end

  def formatted_created_at
    I18n.t(:time_ago, time: h.time_ago_in_words(created_at))
  end

end
