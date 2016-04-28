## Keyword Bot
#
## Summary and Configuration
# This bot responds to up to ten keywords with a simple response. For instance,
# you can set up this bot to respond to 'hours', 'location' and 'specials'.
# To configure the bot, fill in a setting with the keyword and the response
# separated by a colon. As an example, to setup a keyword for hours,
# fill this in on one of the keyword prompts:
#
# KEYWORD_1: 'hours: We are open every day from 9 to five'
#
### Things to keep in mind:
# * Use only one colon (:) for each keyword, or you'll confuse the bot
# * You can put any keyword in any of the ten settings. Only the order
# * in which we report the choices matters to what you use.
#
## Installation
# This bot can be installed on any GreenBot server through the web UI, or
# by through the command line at the greenbot-core root with a
# a 'npm install keyword-bot'
#
# This bot requires a ruby installation, 2.0 or older
## Annoated Bot Code
### Full source in git repo

# Convenience functions for separating the setting into the keyword and the
# response. For instance, KEYWORD_1 may be set to 'hours:We are open every day'
# The keyword function takes whatever is before ':'  and defines that as a
# keyword, in this case 'hours'. The response function would take that same
# keyword string and define that as the response to the keyword (hours, in
# this case) as 'We are open every day'
def keyword(str)
  str.split(':').first.strip.downcase
end

def response(str)
  str.split(':').last
end

# The first message we receive in from the user is also the keyword that
# the user wanted. It is held in the environment variable INITIAL_MSG.
# In order for this bot to work properly, it should either be set as the
# default bot (so it will get every keyword), or every keyword that is
# listed here should also be configured in the network handles to point
# to this bot.
initial_msg = ENV['INITIAL_MSG'].strip.downcase

# Iterate over all of the settings given to the script, and seperate them
# out into the keyword and the response.  Not all settings will be
# defined.
keywords = {}

%w( KEYWORD_1 KEYWORD_2 KEYWORD_3 KEYWORD_4 KEYWORD_5 KEYWORD_6 KEYWORD_7
    KEYWORD_8 KEYWORD_9).each do |p|
  # For each of the settings, check to see that it isn't empty,
  # And that it includes the prompt separator (:)
  setting = ENV[p]
  next if setting.nil? || setting.empty?
  next unless setting.include?(':')

  # Fill in the hash with the keyword as the key, and the rest of the string
  # as the response to that keyword.
  keywords[keyword(setting)] = response(setting)
end

if keywords.keys.include? initial_msg
  # the message that somebody texted in matches one of our keywords.
  # Send back the matching response.
  puts keywords[initial_msg]
else
  # the message that somebody texted does not match any of our keywords.
  # Send back the valid choices.
  puts "Please choose from: #{keywords.keys.join(',')}"
end
