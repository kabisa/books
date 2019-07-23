module Bootstrap
  # This class represents the Alert of Daemonite's Material UI.
  # See: http://daemonite.github.io/material/docs/4.1/components/alerts/
  class Alert
    BS_ALERT_TYPES = %i[primary secondary success info warning danger].freeze
    delegate :flash, :raw, :content_tag, :safe_join, to: :@template

    attr_reader :options, :template, :dismissible

    # @param [Hash] options
    # @option options [Symbol] :class Extra classname added to the flash div
    # @option options [Symbol] :dismissible Set to `true` to show a close button
    def initialize(options, template)
      @dismissible = options.delete(:dismissible)
      @options     = options
      @template    = template
    end

    def render
      safe_join flash_messages
    end

    private

    def flash_messages
      flash.map do |type, message|
        # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
        next if message.blank?
        next if (bs_type = bs_type(type)).nil?

        flash_message(Array(message), bs_type)
      end.flatten.compact
    end

    def bs_type(type)
      bs_type = case type.to_sym
                when :notice then :success
                when :alert, :error then :danger
                else type.to_sym
                end

      BS_ALERT_TYPES.include?(bs_type) ? bs_type : nil
    end

    def flash_message(messages, type)
      tag_options = tag_options(type)

      messages.delete_if(&:nil?).map do |msg|
        content_tag(:div, safe_join([msg, close_button]), tag_options)
      end
    end

    def tag_options(type)
      {
        class: tag_class(type),
        role: :alert
      }.merge(options)
    end

    def tag_class(type)
      tag_class = options.extract!(:class)[:class].to_s
      tag_class << " alert-dismissible fade show" if dismissible
      tag_class << " alert alert-#{type}"
    end

    def close_button
      return '' unless dismissible

      @close_button ||= begin
                          content_tag(:button, type: 'button', class: 'close', 'data-dismiss' => 'alert', 'aria-label' => 'Close') do
                            content_tag(:span, '×', 'aria-hidden' => true)
                          end
                        end
    end
  end
end
