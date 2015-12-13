
require 'highline'

class Reader

  cli = HighLine.new
  answer = cli.ask "What do you think?"
  puts "You have answered: #{answer}"

  # Default answer
  cli.ask("Company?  ") { |q| q.default = "none" }

  cli.say("This should be <%= color('bold', BOLD) %>!")

  cli.choose do |menu|
    menu.prompt = "Please choose your favorite programming language?  "
    menu.choice(:ruby) { cli.say("Good choice!") }
    menu.choices(:python, :perl) { cli.say("Not from around here, are you?") }
  end

end
