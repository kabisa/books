module BooksWorld
  def within_list_group
    within('.list-group') do
      yield
    end
  end
end

World(BooksWorld)
