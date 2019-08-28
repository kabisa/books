require 'bootstrap/alert'

module BootstrapHelper
  def bs_flash(options = {})
    Bootstrap::Alert.new(options, self).render
  end

  # @param icon [String] For all available icons, please refer to Material icons library (https://material.io/resources/icons/)
  def material_icon(icon, options={})
    options.deep_merge!({ class: 'material-icons' })
    content_tag(:i, icon, options)
  end

  def tooltipify(title)
    {
      data: { toggle: 'tooltip' },
      title: title
    }
  end
end
