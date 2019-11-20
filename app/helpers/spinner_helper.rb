module SpinnerHelper
  # See also app/javascript/styles/modules/_spinner.scss
  def spinner
    tag.div(class: 'spinner') do
      concat tag.span(class: 'spinner-inner-1')
      concat tag.span(class: 'spinner-inner-2')
    end
  end
end
