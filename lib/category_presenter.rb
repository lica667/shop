class CategoryPresenter

  def initialize(category)
    @category = category
  end

  def present
    hash = {
      name: @category.name.to_s,
      id: @category.id
    }
    if !@category.categories.empty?
      hash[:categories] = Array.new()
      @category.categories.each do |c|
        cat = CategoryPresenter.new(c).present
        hash[:categories] << cat
      end
    end
    return hash
  end

end