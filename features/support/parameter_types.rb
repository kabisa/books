ParameterType(
  name: 'book_type',
  regexp: /(e-book|printed book)(?:s?)/,
  transformer: -> (type) { type }
)

ParameterType(
  name: 'can_or_not',
  regexp: /((?:(?:\s*can|))(not|)) ?/,
  use_for_snippets: false,
  transformer: ->(str) { str != 'cannot' }
)

ParameterType(
  name: 'do_or_not',
  regexp: /((?:(?:\s*do\s*|))(not|)) ?/,
  use_for_snippets: false,
  transformer: -> (str) { str != 'do not' }
)

ParameterType(
  name: 'like_or_dislike_icon',
  regexp: /Like|like|Dislike|dislike/,
  use_for_snippets: false,
  transformer: -> (str) do
    { 'like' => 'thumb_up',
      'dislike' => 'thumb_down'}[str.downcase]
  end
)

ParameterType(
  name: 'likes_or_dislikes',
  regexp: /(?:people\s)(like|dislike)/,
  use_for_snippets: false,
  transformer: -> (str) { str }
)
