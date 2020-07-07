module CapybaraFinders
  def list_item(content)
    find("ul:not(.actions) li", text: content)
  end
end