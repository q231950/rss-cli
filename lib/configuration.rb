require 'fileutils'

class Configuration

  def initialize
    create_config_unless_exists
  end

  def feeds    
    path = ENV['HOME'] + '/.rss_reader_config.yml'
    config = YAML.load_file(path)
    config['feeds']
  end

  # Creates a config file in case it doesn't exist yet
  private
  def create_config_unless_exists
    path = ENV['HOME'] + '/.rss_reader_config.yml'
    unless File.exists?(path)
      create_sample_config(path)
      puts "Could not find config file.\nA config file has been created for you and can be found here:\n\t" + path + "\n"
    end
  end

  def create_sample_config(path)
    puts("Creating sample file")
    FileUtils.cp './resources/sample_config.yml', path
    #out_file = File.new(path, "w")
    #out_file.puts("#This is a sample configuration for a cli RSS reader.\n")
    #out_file.close
  end

end

