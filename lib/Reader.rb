
require 'highline'
require_relative 'rss-aggregator'

class Reader

  def initialize
    @cli = HighLine.new
    @cli.say("Available feeds:")
    @cli.choose do |menu|
      menu.prompt = "Please choose your favourite feed."
      menu.choices(:heise) {
        handle_name_url("Heise", "http://www.heise.de/newsticker/heise-atom.xml")
      }
    end
  end

  protected
  def handle_name_url(name, url )
    @cli.say("Ok let's go checkout #{name}.") 
    aggregator = RSSAggregator.new([url])
    show_choices_for_items(aggregator.feed_for_url(url).items)
  end

  def show_choices_for_items(items) 
    @cli.choose do |menu|
      items.each do |item|
        title = item.title.to_s
        menu.choice(title) {
          puts item.link
        }
      end
    end
  end
end

Reader.new
