



# Default Bot

# Summary
This bot is just like an 'under construction' page for a website.  Until
a better bot can be installed here, this one will take the message and
forward it to the owner of the account. It has no settings.


# Installation
This bot can be installed on any GreenBot server through the web UI, or
by through the command line at the greenbot-core root with a
a 'npm install default-bot'

This bot requires a ruby installation, 2.0 or older
# Annoated Bot Code
## Full source in git repo
./lib/greenbot.rb is a convenience library for IO. Used for note, confirm..


  

```
require './lib/greenbot.rb'
require 'timeout'


```







Ask user if they want us to contact the owner of the bot


  

```
tell 'Thank you for texting us. This KISST bot is currently under construction. If you are looking for the owner of this number, I can take a message.'
if confirm('Would you like someone to contact you?')

```







If so, set the contact me to true and save it in the collected data


  

```
  contact_me = true
  contact_me.remember('contact_me')


```







Ask for the persons name, and remember it.


  

```
  name = ask('When we call, who should we ask for?')
  name.remember('who_to_ask_for')


```







Ask for another number, collect it if you can.


  

```
  if confirm('Is there another number we should try?')
    better_number = ask('Please enter that number with an area code')
    better_number.remember('better_number')
  end
end


```







Ask if they want us to take a message for hte owner. Use the note
function so we can take multiple messages.


  

```
if confirm('Would you like to leave a message?')
  note = note('How can we help you? Please use as many messages as you need.')
  note.remember('note')
  tell 'Thank you. We will forward the message.'
end


```







And that's it. Say good bye


  

```
tell 'Goodbye.'


```




