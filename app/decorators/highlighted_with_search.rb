# This module contains methods that return attributes or other text
# with the keywords entered in the search field.
module HighlightedWithSearch
  def title_highlighted_with_search
    h.highlight(title, title_or_summary_or_writers_name_cont)
  end

  def summary_highlighted_with_search
    h.highlight(h.simple_format(summary), title_or_summary_or_writers_name_cont)
  end

  def written_by_highlighted_with_search
    return if writers.none?

    I18n.t('activerecord.attributes.book.written_by', writer_names: writer_names_highlighted_with_search.to_sentence).html_safe
  end

  private

  def title_or_summary_or_writers_name_cont
    h.params[:q]&.fetch(:title_or_summary_or_writers_name_cont)
  end

  def writer_names_highlighted_with_search
    writer_names.map do |name|
      writer_name_highlighted_with_search(name)
    end
  end

  def writer_name_highlighted_with_search(writer_name)
    h.highlight(writer_name, title_or_summary_or_writers_name_cont)
  end
end
