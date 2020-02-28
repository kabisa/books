module MaterialHelper
  def bs_snackbar
    render(Material::Snackbar, flash: flash)
  end

  def navigation_icon
    render(Material::NavigationIcon, action_name: action_name)
  end
end
