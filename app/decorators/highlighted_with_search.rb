# This module contains methods that return attributes or other text
# with the keywords entered in the search field.
module HighlightedWithSearch
  def title_highlighted_with_search
    highlighted_with_search(title)
  end

  def summary_highlighted_with_search
    highlighted_with_search(h.simple_format(summary))
  end

  def written_by_highlighted_with_search
    return if writers.none?

    I18n.t('activerecord.attributes.book.written_by', writer_names: writer_names_highlighted_with_search.to_sentence).html_safe
  end

  private

  def highlighted_with_search(text)
    h.highlight(text, title_or_summary_or_writers_name_cont)
  end

  def title_or_summary_or_writers_name_cont
    h.params.dig(:q, :title_or_summary_or_writers_name_cont)
  end

  def writer_names_highlighted_with_search
    writer_names.map do |name|
      writer_name_link_highlighted_with_search(name)
    end
  end

  def writer_name_highlighted_with_search(writer_name)
    highlighted_with_search(writer_name)
  end

  def writer_name_link_highlighted_with_search(writer_name)
    name         = writer_name_highlighted_with_search(writer_name)
    options      = { q: { writers_name_eq: writer_name } }
    html_options = { class: 'text-primary' }

    h.link_to(name, h.books_path(options), html_options)
  end
end
