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
  # a floating action button.
  # Often used with an icon as button value.
  # @param [String|Array<String>] extra classnames that are added to the output
  # @return [String] classnames
  # @example
  #   fab_class #=> 'btn-float btn'
  #   fab_class('my-1 text-primary') #=> 'btn-float btn my-1 text-primary'
  #   fab_class(%(my-1 text-primary)) #=> 'btn-float btn my-1 text-primary'
  def fab_class(classnames=nil)
    default_classnames = %w(btn-float btn)
    join_classnames(default_classnames, classnames)
  end

  # Minimal set of classnames needed to create
  # a small round button.
  # Often used with an icon as button value.
  # @param [String|Array<String>] extra classnames that are added to the output
  # @return [String] classnames
  # @example
  #   sm_rnd_btn_class #=> 'btn-float btn btn-sm shadow-none'
  #   sm_rnd_btn_class('my-1 text-primary') #=> 'btn-float btn btn-sm shadow-none my-1 text-primary'
  #   sm_rnd_btn_class(%(my-1 text-primary)) #=> 'btn-float btn btn-sm shadow-none my-1 text-primary'
  def sm_rnd_btn_class(classnames=nil)
    default_classnames = Array(fab_class(%w(btn-sm shadow-none)))
    join_classnames(default_classnames, classnames)
  end

  # Renders a close icon
  # @see http://daemonite.github.io/material/docs/4.1/utilities/close-icon/
  def close_icon(options = {})
    options.deep_merge!(class: 'close', type: :button, aria: { label: 'Close' })

    tag.button(options) do
      tag.span('×', aria: { hidden: true })
    end
  end

  private

  def join_classnames(default_classnames, classnames)
    (Array(default_classnames) + Array(classnames)).join(' ')
  end

end
