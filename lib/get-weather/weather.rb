require 'nokogiri'
require 'open-uri'

class GetWeather::Weather

  attr_accessor :location, :temperature, :feels_like, :wind, :humidity, :description

  def self.get_zip(zip_code)
    get_weather(zip_code) if zip_code != 'done'
    # Scrape woot and meh and then return deals based on that data
  end

  def self.get_weather(zip_code)
    weather = scrape_weather(zip_code)

    weather
  end

  def self.scrape_weather(zip_code)
    url = "https://weather.com/weather/today/l/#{zip_code}:4:US"
    begin
      doc = Nokogiri::HTML(open(url))
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        puts "Zip code not found. Please enter another:"
      end
    end
    set_weather(doc) if doc
  end

  def self.set_weather(doc)
    weather = self.new
    weather.location = doc.search("h1.h4.today_nowcard-location").text.strip
    weather.temperature = doc.search("div.today_nowcard-temp span").text.strip
    weather.feels_like = doc.search(".deg-feels").text.strip
    weather.wind = doc.search("div.today_nowcard-sidecar.component.panel table tbody td span")[0].text.strip
    weather.humidity = doc.search("div.today_nowcard-sidecar.component.panel table tbody td span")[1].text.strip
    weather.description = doc.search("span.today-wx-descrip").text.strip

    weather
  end

end