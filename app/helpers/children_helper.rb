module ChildrenHelper

  def age(child)
    Date.current.year - child.birth_year
  end

end
