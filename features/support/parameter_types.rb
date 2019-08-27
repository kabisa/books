ParameterType(
  name: 'book_type',
  regexp: /(e-books|printed books)/,
  transformer: -> (type) { /#{type.singularize}/i }
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
  transformer: -> (str) { p str; str != 'do not' }
)
