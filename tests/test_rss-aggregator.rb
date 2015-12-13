require "rss-aggregator"
require "test/unit"

class TestRSSAggregator < Test::Unit::TestCase
  
  def setup
    args = []
    @aggregator = RSSAggregator.new(args)
  end
  
  def test_number_of_feeds
    assert_equal(0, @aggregator.feed_count)
  end
  
  def test_add_feed
    @aggregator.add_url("http://www.tagesschau.de/xml/rss2")
  end
  
  def test_refreshes_after_adding_url
    @aggregator.add_url("http://www.tagesschau.de/xml/rss2")
    assert_equal(1, @aggregator.feed_count)
  end
  
  def test_removes_duplicates_when_initializing
    args = ["http://www.tagesschau.de/xml/rss2", "http://www.tagesschau.de/xml/rss2"]
    @aggregator = RSSAggregator.new(args)
    assert_equal(1, @aggregator.feed_count)
  end
  
  def test_ignores_adding_duplicate_urls()
    @aggregator.add_url("http://www.tagesschau.de/xml/rss2")
    @aggregator.add_url("http://www.tagesschau.de/xml/rss2")
    assert_equal(1, @aggregator.feed_count)
  end
  
  def test_number_of_something
    assert_equal(3, 2+1)
  end
  
end