require 'test/unit'
require 'feed'

class FeedTest < Test::Unit::TestCase

  def setup
    @feed = Feed.new('some feed title', 'http://www.heise.de/newsticker/heise-atom.xml')
  end

  def test_articles_are_empty_after_initialization
    assert_equal([], @feed.articles)
  end

  def test_title_is_correct
    assert_equal('some feed title', @feed.title)
  end

end
