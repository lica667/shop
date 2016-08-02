class CategoryPresenter

  def initialize(category)
    @category = category
  end

  def present
    html = ''
    html << "<li><a href = '/category?id=#{@category.id}'>#{@category.name.to_s}</a></li>"
    # hash = {
    #   name: @category.name.to_s,
    #   id: @category.id
    # }
    if !@category.categories.empty?
      html << "<ul id=#category_#{@category.id}>"
      # hash[:categories] = Array.new()
      @category.categories.each do |c|
        cat = CategoryPresenter.new(c).present
        # hash[:categories] << cat
        html << cat
      end
      html << "</ul>"
    end
    return html
  end

end