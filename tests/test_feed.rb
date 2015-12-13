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

  def test_adds_multiple_articles 
    article1 = flexmock('article 1')
    article2 = flexmock('article 2')
    @feed.add_article(article1)
    @feed.add_article(article2)
    assert_equal(2, @feed.articles.size)
  end

  def test_ignores_duplicate_articles
    article = flexmock('article')
    @feed.add_article(article)
    @feed.add_article(article)
    assert_equal(1, @feed.articles.size)
  end

end
