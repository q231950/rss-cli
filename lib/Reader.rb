require 'highline'
require_relative 'rss-aggregator'
require_relative 'configuration'
require 'yaml'

class Reader

  def initialize args
    setup_properties
    write_welcome_message
    parse_argv(args)

    unless @help.nil?
      show_help
    end

    unless @read.nil?
      read
    end

    puts "Bye bye."
  end

  public
  def read
    @cli.say("Your RSS feeds:")
    @cli.choose do |menu|
      menu.prompt = "Choose a feed or quit by either choosing '" + (@configuration.feeds.length + 1).to_s + "' or entering the letter 'q'."
      @configuration.feeds.each do |feed| 
        nameSymbol = feed['name'].to_sym
        menu.choices(nameSymbol) {
          handle_name_url(feed['name'], feed['url'])
        } 
      end
      menu.choice(:'quit (q)', :q) {
      }
    end
  end

  private
  def setup_properties
    @cli = HighLine.new
    @configuration = Configuration.new
    @aggregator = RSSAggregator.new([])
  end

  def write_welcome_message
    file = File.open('resources/welcome_message.txt') 
    @cli.say(file.read)
  end

  def parse_argv(args)
    unless args.nil? 
      args.each do |k, v|
        if k == "read"
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
    @cli.say("Ok, checking out #{ name }...") 
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
          show_choices_for_items(items)
        }
      end
      menu.choice(:'back (b)', :'(b)') {
        read
      }
      menu.choice(:'quit (q)', :q) {
      }
    end
  end
end

kv = ARGV
Reader.new(kv)

