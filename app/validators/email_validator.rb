class EmailValidator < ActiveModel::EachValidator
  attr_reader :value

  AUTHORIZED_DOMAINS = %w(kabisa.nl)

  def validate_each(record, attribute, value)
    @value = value

    return if value.blank?

    if not_an_email_address?
      record.errors.add attribute, (options[:message] || :not_an_email_address)
    elsif unauthorized?
      record.errors.add attribute, (options[:message] || :unauthorized)
    end
  end

  private

  def not_an_email_address?
    value !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def unauthorized?
    !authorized_domain?
  end

  def authorized_domain?
    AUTHORIZED_DOMAINS.include?(domain)
  end

  def domain
    value.split('@').last
  end
end
