# pcResFeed
Put an RSS feed in Envisionware's PC Reservation client

## Overview
This simple script takes an RSS feed (generated, let's say, by your library's Evanced SignUp calendar) and cleans it up a bit for display on the PC Reservation client screen. There is a left sidebar that will display the contents of an RSS file saved in the appropriate directory. Since there are visual limitations on what that sidebar displays, the script trims down descriptions to dates, times, and locations.

Uses Psych and Nokogiri.

## How to use
If you don't already have them, run: `gem install psych` and `gem install nokogiri`

Open `locations-template.yml`. Replace the info there with yours, and copy-paste more entries as necessary. For example, if you're in a library branch system and are running an instance of PC Res for each branch, you'll need to account for each location here (and provide location-specific RSS if available). Save this file as `locations.yml`.

Now all you have to do is run the script, `pcresfeed.rb`. You may want to make it a cronjob. This way the PC Res feed can update every morning and promote upcoming events to your patrons.

The default number of events is five, because I've found this works well. However, if you want to change it, change the `eventmax` variable on line 8.

## To-do
Error handling
