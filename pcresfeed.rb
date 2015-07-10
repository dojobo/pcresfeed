require 'fileutils'
require 'nokogiri'
require 'open-uri'
require 'psych'

locations = Psych.load_file('locations.yml')
#locations = [{"name"=>"test", "source"=>"http://ebrpl.evanced.info/signup/eventsxml.aspx?ag=&et=&lib=0&nd=31&dm=rss&LangType=0", "destination"=>"rss/test.rss"}]
eventmax = 5  # how many events to show

locations.each do |location|
  puts "doing #{location["name"]}"
  open("#{location["destination"]}en_us.rss", "w") do |file|
    feed = Nokogiri::XML.parse(open(location["source"]))
    title = feed.xpath("/rss/channel/title").first
    title.content = "Events @ Your Library!"
    
    eventcount = 0
    feed.xpath("/rss/channel/item").each do |item|
      eventcount += 1
      if eventcount > eventmax then
        item.remove
      end
    end

    feed.xpath("/rss/channel/item/description").each do |desc|
      #puts desc.content[/^(.*?\&lt;br \/\&gt.*?)\&lt;br \/\&gt;/]  # pattern from old perl script
      desc.content = desc.content[/^(.*?<br \/>.*?)<br \/>/]  # nokogiri parses amp-codes as normal characters i guess?
      desc.content = desc.content.gsub(/<b>|<\/b>|When:|Where:/, '')
      desc.content = desc.content.gsub(/<br \/>/, ';')
      desc.content = desc.content.gsub(/2015 |2016 |2017 |2018 |2019 /, '') # instead of /20\d\d/ to avoid e.g. Word 2010
      desc.content = desc.content.gsub(/;$/, '')
    end
    file.puts feed
  end
end