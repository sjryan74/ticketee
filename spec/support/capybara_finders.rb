module CapybaraFinders
  def list_item(content)
    find("ul:not(.actions) li", text: content)
  end

  def tag(content)
    find("div.tag", text: content)
  end
end