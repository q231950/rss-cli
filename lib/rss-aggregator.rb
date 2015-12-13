#!/usr/bin/ruby

require 'rubygems'
require 'simple-rss'
require 'open-uri'

class RSSAggregator
  def initialize(urls)
    @feed_urls = urls.uniq
    @feeds = []
    read_feeds
  end

  protected
  def read_feeds
    @feed_urls.each { |url| @feeds.push(SimpleRSS.new(open(url).read)) }
  end

  public
  def refresh
    @feeds = []
    read_feeds
  end
  
  def add_url(url)
    if @feed_urls.any? { |obj| obj == url }
        return
    end
    
    @feed_urls.push(url)
    refresh
  end
  
  def feed_count
    @feeds.size
  end

  def channel_counts
    @feeds.each_with_index do | feed, index |
      channel = "Channel(#{index.to_s}): #{feed.channel.title}"
      articles = "Articles: #{feed.items.size.to_s}"
      puts channel + ', ' + articles
    end
  end

  def list_articles(id)
    puts "=== Channel(#{id.to_s}): #{@feeds[id].channel.title} ==="
    @feeds[id].items.each { |item| puts ' ' + item.title + "( #{item.link.to_s} )" }
  end

  def list_all
    @feeds.each_with_index { | feed, index | list_articles(index) }
  end
end
#
#aggregator = RSSAggregator.new(ARGV)
#aggregator.channel_counts
#puts '\n'
#aggregator.list_all

