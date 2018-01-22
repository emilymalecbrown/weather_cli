class GetWeather::CLI

  def call
    menu
    goodbye
  end


  def menu
    puts "Please enter a zipcode to check weather:"
    input = nil
    while input != "done"
      input = gets.strip.downcase
      weather = GetWeather::Weather.get_zip(input)
      if weather
        puts "--------------------------------"
        puts weather.location
        add_emojis_to_weather(weather)
        puts "The current temperature is #{weather.temperature}and it feels like #{weather.feels_like}"
        puts "Humidity: #{weather.humidity}"
        puts "Wind: #{weather.wind}"
        puts weather.description
        puts "--------------------------------"
        puts "Type 'done' to exit or enter another zip code:"
      end
    end
  end

  def add_emojis_to_weather(weather)
    desc = weather.description.downcase
    if desc.include? "cloud"
      puts "☁️ ☁️ ☁️ ☁️ ☁️ ☁️ ☁️ ☁️ ☁️"
    elsif desc.include? "rain"
      puts "🌧️ 🌧️ 🌧️ 🌧️ 🌧️ 🌧️ 🌧️ 🌧️ 🌧️"
    elsif desc.include? "partly"
      puts "⛅ ⛅ ⛅ ⛅ ⛅ ⛅ ⛅ ⛅ ⛅"
    elsif desc.include? "sun"
      puts "☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ☀️ ☀️"
    end
  end

  def goodbye
    puts "Have a bright and sunshine-y day!"
  end

end
