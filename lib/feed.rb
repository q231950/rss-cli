
class Feed

  def initialize(title='', url)
    @title = title    
    @url = url
  end

  def title
    @title
  end

  def url
    @url
  end

  def articles
    []
  end

end
