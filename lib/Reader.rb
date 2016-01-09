require 'highline'
require_relative 'rss-aggregator'

class Reader

  def initialize args
    @cli = HighLine.new
    parse_argv(args)

    unless @help.nil?
      show_help
    end

    unless @read.nil?
      puts 'will read now'
      read
    end
  end

  public
  def read
    puts @cli
    @cli.say("Available feeds:")
    @cli.choose do |menu|
      menu.prompt = "Please choose your favourite feed."
      menu.choices(:Heise) {
        handle_name_url("Heise", "http://www.heise.de/newsticker/heise-atom.xml")
      }
      menu.choice(:Tageschau) {
        handle_name_url("Tagesschau", "http://www.tagesschau.de/xml/rss2")
      }
      menu.choice(:BitBucket) {
        handle_name_url("BitBucket", "https://bitbucket.org/q231950/rss/feed?token=ad4563c793715091572c309bb8b4ca03")
      }
      menu.choice(:ROOPC) {
        handle_name_url("ROOPC", "http://roopc.net/rss.xml")
      }
    end
  end

  private
  def parse_argv(args)
    unless args.nil? 
      puts args
      args.each do |k, v|
        if k == "read"
          puts k.inspect
          instance_variable_set("@#{k}", true) 
        elsif k == :cli
          @cli = v
        end
      end
    end
  end

  def show_help
    @cli.say("<%= color('reader', BOLD) %> supports a single command:\n• reader <%= color('read', BOLD) %>")
  end

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
          ok = system("open -a safari " + item.link)
          puts ok
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

kv = ARGV
Reader.new(kv)

