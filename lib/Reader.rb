require 'highline'
require_relative 'rss-aggregator'
require_relative 'configuration'
require 'yaml'

class Reader

  def initialize args
    @configuration = Configuration.new
    @cli = HighLine.new
    @aggregator = RSSAggregator.new([])
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
    @cli.say("Available feeds:")
    @cli.choose do |menu|
      menu.prompt = "Please choose your favourite feed."
      @configuration.feeds.each do |feed|
          nameSymbol = feed['name'].to_sym
          menu.choices(nameSymbol) {
          handle_name_url(feed['name'], feed['url'])
        }
      end
      menu.choice(:Cancel) {
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
    #@configuration.feeds.map {|feed| feed['url']}
    @aggregator.add_url(url)
    show_choices_for_items(@aggregator.feed_for_url(url).items)
  end

  def show_choices_for_items(items) 
    @cli.choose do |menu|
      items.each do |item|
        title = item.title.to_s
        menu.choice(title) {
          # open safari
          system("open -a safari " + item.link)
#          @cli.choose do |sub_menu|
#            sub_menu.prompt = "Back to results?"
#            sub_menu.choice(:yes) {
              show_choices_for_items(items)
#            }
#            sub_menu.choice(:no) {
#            }
#          end
        }
      end
      menu.choice(:back) {
        read
      }
    end
  end
end

kv = ARGV
Reader.new(kv)

