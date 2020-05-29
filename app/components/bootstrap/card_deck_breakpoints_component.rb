module Bootstrap
  # See also: https://www.codeply.com/go/nIB6oSbv6q - How to add breakpoint to make card deck responsive.
  # This component has no template, all markup is rendered
  # by the `call` method.
  class CardDeckBreakpointsComponent < ViewComponent::Base
    def initialize(tag_counter:, sm: 2, md: 3, lg: 4, xl: 5)
      @tag_counter = tag_counter
      @sm = sm
      @md = md
      @lg = lg
      @xl = xl
    end

    def call
      capture do
        concat wrap_on_sm
        concat wrap_on_md
        concat wrap_on_lg
        concat wrap_on_xl
      end
    end

    private

    def wrap_on_sm
      return if not_a_breakpoint?(@sm)

      classnames = default_classnames << 'd-sm-block'
      classnames << hide_on_classnames(:sm)

      tag.div(class: classnames)
    end

    def wrap_on_md
      return if not_a_breakpoint?(@md)

      classnames = default_classnames << 'd-md-block'
      classnames << hide_on_classnames(:md)

      tag.div(class: classnames)
    end

    def wrap_on_lg
      return if not_a_breakpoint?(@lg)

      classnames = default_classnames << 'd-lg-block'
      classnames << hide_on_classnames(:lg)
      tag.div(class: classnames)
    end

    def wrap_on_xl
      return if not_a_breakpoint?(@xl)

      classnames = default_classnames << 'd-xl-block'
      tag.div(class: classnames)
    end

    def not_a_breakpoint?(breakpoint)
      breakpoint.nil? || (@tag_counter % breakpoint).nonzero?
    end

    def default_classnames
      %w[w-100 d-none]
    end

    def hide_on_classnames(breakpoint)
      [hide_on_md(breakpoint), hide_on_lg(breakpoint), hide_on_xl(breakpoint)]
    end

    def hide_on_md(breakpoint)
      return if @md.nil?
      return if breakpoint != :sm

      'd-md-none'
    end

    def hide_on_lg(breakpoint)
      return if @lg.nil?
      return if %i[sm md].exclude?(breakpoint)

      'd-lg-none'
    end

    def hide_on_xl(breakpoint)
      return if @xl.nil?
      return if %i[sm md lg].exclude?(breakpoint)

      'd-xl-none'
    end
  end
end
