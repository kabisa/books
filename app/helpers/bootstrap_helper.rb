require 'bootstrap/alert'

module BootstrapHelper
  # @param icon [String] For all available icons, please refer to Material icons library (https://material.io/resources/icons/)
  def material_icon(icon, options = {})
    default_options = { class: 'material-icons' }

    options.deep_merge!(default_options) do |key, this_val, other_val|
      [this_val, other_val].join(' ').strip
    end

    content_tag(:i, icon, options)
  end

  def tooltipify(title, data_attributes = {})
    data = { toggle: 'tooltip' }.merge(data_attributes)
    { data: data, title: title }
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
  def fab_class(classnames = nil)
    default_classnames = %w[btn-float btn]
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
  def sm_rnd_btn_class(classnames = nil)
    default_classnames = Array(fab_class(%w[btn-sm shadow-none]))
    join_classnames(default_classnames, classnames)
  end

  def sm_btn_class(classnames = nil)
    default_classnames = %w[btn btn-sm]
    join_classnames(default_classnames, classnames)
  end

  # Renders a close icon
  # @see http://daemonite.github.io/material/docs/4.1/utilities/close-icon/
  def close_icon(options = {})
    default_options = {
      class: 'close', type: :button, aria: { label: 'Close' }
    }
    # Deep merge and join values
    options.deep_merge!(default_options) do |key, this_val, other_val|
      [this_val, other_val].join(' ').strip
    end

    tag.button(options) { tag.span('×', aria: { hidden: true }) }
  end

  def responsive_card_deck(idx)
    capture do
      concat wrap_every_2_on_sm(idx + 1)
      concat wrap_every_3_on_md(idx + 1)
      concat wrap_every_4_on_lg(idx + 1)
      concat wrap_every_5_on_xl(idx + 1)
    end
  end

  def wrap_every_2_on_sm(tags_count)
    return if (tags_count % 2).nonzero?

    tag.div(class: 'w-100 d-none d-sm-block d-md-none')
  end

  def wrap_every_3_on_md(tags_count)
    return if (tags_count % 3).nonzero?

    tag.div(class: 'w-100 d-none d-md-block d-lg-none')
  end

  def wrap_every_4_on_lg(tags_count)
    return if (tags_count % 4).nonzero?

    tag.div(class: 'w-100 d-none d-lg-block d-xl-none')
  end

  def wrap_every_5_on_xl(tags_count)
    return if (tags_count % 5).nonzero?

    tag.div(class: 'w-100 d-none d-xl-block')
  end

  private

  def join_classnames(default_classnames, classnames)
    (Array(default_classnames) + Array(classnames)).join(' ')
  end
end
