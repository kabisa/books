class NullUser
  def anonymous?
    true
  end

  def identified?
    false
  end

  def id
    nil
  end

  def email
    nil
  end

  def errors
    { email: [] }
  end

  def valid?
    true
  end
end
