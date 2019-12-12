require 'active_support/concern'

# When sorting a table, records with NULLs will be displayed first.
# If this is not want you want, you need to write a custom `where` and include
# `NULLS LAST`, e.g. Book.order('num_of_pages NULLS LAST').
#
# This module exposes a method that gives you 2 scopes for each attribute
# passed to it. The name of each scope matches the naming expected by Ransack
# so they can be used in the Ransack sort_link helper.
#
#   sort_by_nulls_last :num_of_pages
#
# is the same as defining the following scopes in the model:
#
#   scope :sort_by_num_of_pages_nulls_last_asc, -> { order('num_of_pages ASC NULLS LAST') }
#   scope :sort_by_num_of_pages_nulls_last_desc, -> { order('num_of_pages DESC NULLS LAST') }
#
# When using Ransack, you can create a link to sort on this attribute, as follows:
#
#   sort_link(@q, :num_of_pages)
#
# `sort_by_nulls_last` can expect multiple attributes, so instead of:
#
#    sort_by_nulls_last :num_of_pages
#    sort_by_nulls_last :published_on
#
#  you can also write:
#
#    sort_by_nulls_last :num_of_pages, :published_on
#
module SortByNullsLast
  extend ActiveSupport::Concern

  class_methods do
    DIRS = [:asc, :desc]

    def sort_by_nulls_last(*attributes)
      attributes.each do |attribute|
        DIRS.each do |dir|
          scope "sort_by_#{attribute}_nulls_last_#{dir}".to_sym,
            -> { order("#{attribute} #{dir.upcase} NULLS LAST") }
        end
      end
    end
  end
end

