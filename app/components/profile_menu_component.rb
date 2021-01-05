class ProfileMenuComponent < ViewComponent::Base
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def item_class
    avatar? ? 'navbar-toggler' : %w[btn btn-outline dropdown-toggle]
  end

  def item_id
    'dropdownMenuLink'
  end

  def item_attributes
    attributes = {
      id: item_id,
      class: item_class,
      aria: { expanded: false, haspopup: :true },
      data: { toggle: :dropdown },
      href: '#'
    }

    attributes[:role] = :button unless avatar?

    attributes
  end

  def avatar?
    user.avatar?
  end
end
