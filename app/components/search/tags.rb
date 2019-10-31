module Search
  class Tags < ActionView::Component::Base
    include Ransack::Helpers::FormHelper
    extend ActiveModel::Naming

    def initialize(q:, builder:)
      @q = q
      @builder = builder
    end

    private

    attr_reader :q, :builder
    alias :f :builder

    def tags_count
      Array(q.tags_id_in).size
    end

    def dom_id
      [model_name.singular, object_id].join('-')
    end

    def zero_tags_classnames
      class_names = %w(zero-tags)
      class_names << 'd-none' if tags_count.nonzero?
      class_names
    end

    def other_tags_classnames
      class_names = %w(other-tags)
      class_names << 'd-none' if tags_count.zero?
      class_names
    end

    def dropdown_button(zero_or_other, &block)
      class_names = %w(btn btn-sm dropdown-toggle)

      case zero_or_other
      when:zero
        class_names << zero_tags_classnames
        class_names << 'btn-outline'
      else
        class_names << other_tags_classnames
        class_names << 'btn-outline-primary'
      end

      content_tag(:a, class: class_names, href: '#', role: :button, aria: { expanded: false, haspopup: true }, data: { toggle: :dropdown, offset: '0,10', boundary: dom_id, flip: false }) do
        yield
      end
    end
  end
end
