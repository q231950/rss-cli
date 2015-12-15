
require 'highline'
require_relative 'rss-aggregator'

class Reader

  def initialize
    @cli = HighLine.new
    @cli.say("This should be <%= color('bold', BOLD) %>!")
    @cli.say("Available feeds:")
    @cli.choose do |menu|
      menu.prompt = "Please choose your favourite feed."
      menu.choices(:Heise) {
        handle_name_url("Heise", "http://www.heise.de/newsticker/heise-atom.xml")
      }
      menu.choice(:Tageschau) {
        handle_name_url("Tagesschau", "http://www.tagesschau.de/xml/rss2")
      }
    end
  end

  private
  def handle_name_url(name, url )
    @cli.say("Ok, checking out #{ name }") 
    aggregator = RSSAggregator.new([url])
    show_choices_for_items(aggregator.feed_for_url(url).items)
  end

  def show_choices_for_items(items) 
    @cli.choose do |menu|
      items.each do |item|
        title = item.title.to_s
        menu.choice(title) {
          puts item.link
          #@cli.ask("Back to results?")
          @cli.choose do |sub_menu|
            sub_menu.prompt = "Back to results?"
            sub_menu.choice(:yes) {
              puts items.size
              show_choices_for_items(items)
            }
            sub_menu.choice(:no) {
            }
          end
        }
      end
    end
  end
end

Reader.new
