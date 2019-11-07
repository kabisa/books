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

  # Minimal set of classnames needed to create
  # a small round button.
  # Often used with an icon as button value.
  # @param [String|Array<String>] extra classnames that are added to the output
  # @return [String] classnames
  # @example
  #   small_round_button #=> 'btn-float btn btn-sm shadow-none'
  #   small_round_button('my-1 text-primary') #=> 'btn-float btn btn-sm shadow-none my-1 text-primary'
  #   small_round_button(%(my-1 text-primary)) #=> 'btn-float btn btn-sm shadow-none my-1 text-primary'
  def small_round_button(classnames=nil)
    default_classnames = %w(btn-float btn btn-sm shadow-none)
    (default_classnames + Array(classnames)).join(' ')
  end

  # Renders a close icon
  # @see http://daemonite.github.io/material/docs/4.1/utilities/close-icon/
  def close_icon(options = {})
    options.deep_merge!(class: 'close', type: :button, aria: { label: 'Close' })

    tag.button(options) do
      tag.span('×', aria: { hidden: true })
    end
  end
end
