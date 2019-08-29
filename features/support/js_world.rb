module JsWorld
  def js?
    page.mode == :selenium
  end
end

World(JsWorld)
