require 'test/unit'
require 'feed'
require 'flexmock'

  @@URL = 'http://www.heise.de/newsticker/heise-atom.xml'
class FeedTest < Test::Unit::TestCase

  
  def setup
    @feed = Feed.new('some feed title', @@URL)
  end

  def test_articles_are_empty_after_initialization
    assert_equal([], @feed.articles)
  end

  def test_title_is_correct
    assert_equal('some feed title', @feed.title)
  end

  def test_url_is_correct
    assert_equal(@@URL, @feed.url)
  end

  def test_add_article
    article = flexmock('article')
    @feed.add_article(article)
    assert_equal(1, @feed.articles.size)
  end

end
