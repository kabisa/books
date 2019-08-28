class UrlValidator < ActiveModel::EachValidator
  attr_reader :value

  def validate_each(record, attribute, value)
    @value = value

    return if value.blank?

    record.errors.add attribute, (options[:message] || :not_a_url) unless valid_url?
  end

  private

    def valid_url?
      value =~ /^#{URI::regexp}$/
    end
end
