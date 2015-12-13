
require 'highline'
require_relative 'rss-aggregator'

class Reader

  cli = HighLine.new
  #answer = cli.say "Hi there, "
  #puts "You have answered: #{answer}"

  # Default answer
  #cli.ask("Company?  ") { |q| q.default = "none" }

  #cli.say("This should be <%= color('bold', BOLD) %>!")

  cli.say("Available feeds:")
  cli.choose do |menu|
    menu.prompt = "Please choose your favourite feed."
    menu.choices(:heise) { 
      cli.say("Ok let's go checkout Heise") 
      aggregator = RSSAggregator.new(["http://www.heise.de/newsticker/heise-atom.xml"])
      aggregator.list_all
    }
  end

end
