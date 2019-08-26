ParameterType(
  name: 'book_type',
  regexp: /(e-books|printed books)/,
  transformer: -> (type) { /#{type.singularize}/i }
)
