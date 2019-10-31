module Search
  class Likes < ActionView::Component::Base
    include Ransack::Helpers::FormHelper
    extend ActiveModel::Naming

    def initialize(q:, builder:)
      @q = q
      @builder = builder
    end

    private

    attr_reader :q, :builder
    alias :f :builder

    def likes_count
      q.likes_count_gteq || 0
    end

    def dom_id
      [model_name.singular, object_id].join('-')
    end

    def zero_likes_classnames
      class_names = %w(zero-likes)
      class_names << 'd-none' if likes_count.nonzero?
      class_names
    end

    def other_likes_classnames
      class_names = %w(other-likes)
      class_names << 'd-none' if likes_count.zero?
      class_names
    end

    def dropdown_button(zero_or_other, &block)
      class_names = %w(btn btn-sm dropdown-toggle)

      case zero_or_other
      when:zero
        class_names << zero_likes_classnames
        class_names << 'btn-outline'
      else
        class_names << other_likes_classnames
        class_names << 'btn-outline-primary'
      end

      content_tag(:a, class: class_names, href: '#', role: :button, aria: { expanded: false, haspopup: true }, data: { toggle: :dropdown, offset: '0,10', boundary: dom_id, flip: false }) do
        yield
      end
    end
  end
end
