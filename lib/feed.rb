
class Feed

  def initialize(title='', url)
    @title = title    
    @url = url
    @articles = []
  end

  def title
    @title
  end

  def url
    @url
  end

  def add_article(article)
    @articles << article
  end

  def articles
    @articles
  end

end
