module Bootstrap
  # See also: https://www.codeply.com/go/nIB6oSbv6q - How to add breakpoint to make card deck responsive.
  # This component has no template, all markup is rendered
  # by the `call` method.
  class CardDeckBreakpointsComponent < ViewComponent::Base
    def initialize(tag_counter:)
      @tag_counter = tag_counter
    end

    def call
      capture do
        concat wrap_every_2_on_sm
        concat wrap_every_3_on_md
        concat wrap_every_4_on_lg
        concat wrap_every_5_on_xl
      end
    end

    def wrap_every_2_on_sm
      return if (@tag_counter % 2).nonzero?

      tag.div(class: 'w-100 d-none d-sm-block d-md-none')
    end

    def wrap_every_3_on_md
      return if (@tag_counter % 3).nonzero?

      tag.div(class: 'w-100 d-none d-md-block d-lg-none')
    end

    def wrap_every_4_on_lg
      return if (@tag_counter % 4).nonzero?

      tag.div(class: 'w-100 d-none d-lg-block d-xl-none')
    end

    def wrap_every_5_on_xl
      return if (@tag_counter % 5).nonzero?

      tag.div(class: 'w-100 d-none d-xl-block')
    end
  end
end
