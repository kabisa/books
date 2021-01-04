module MaterialHelper
  def bs_snackbar
    render(Material::SnackbarComponent.new(flash: flash))
  end

  def navigation_icon
    render(Material::NavigationIconComponent.new(action_name: action_name))
  end
end
