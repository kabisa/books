module MaterialHelper
  def bs_snackbar
    render(Material::Snackbar.new(flash: flash))
  end

  def navigation_icon
    render(Material::NavigationIcon.new(action_name: action_name))
  end
end
