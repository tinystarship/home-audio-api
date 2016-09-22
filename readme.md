#Home Audio API

# Table of Contents
1. [What is this script] (#what-is-this-script)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Endpoint URLs](#endpoint-urls)
5. [Available Zones](#available-zones)
6. [Sending Commands](#sending-commands)
  1. [Example Commands](#example-commands)
  2. [Toggle Power](#toggle-power)
  3. [Change Sources](#change-sources)
  4. [Adjust Audio](#adjust-audio)

# What is this script
In the fall of 2015 I purchased a whole home audio controller from monoprice. I wanted to control it from my phone. I taught myself Swift and released an app called [Home Audio](https://itunes.apple.com/us/app/home-audio/id1056245809?ls=1&mt=8). It required a special ethernet -> serial adapter to hookup the monoprice's serial adapter to the network, but it worked great. I had a Raspberry Pi 2 sitting in a box looking for a project, so I decided to create a simple Web API for a cheaper option.

Please be aware, this is not the fastest thing in the world. We're going across a serial port. To refresh the status of everything can take some time. Pushing commands should be pretty quick though, I've gotten responses in 1-2 seconds.   

# Requirements
To actually use this script, you need a few things:

1. [Monoprice Whole Home Audio Controller](http://www.monoprice.com/product?p_id=10761). 
2. [Raspberry Pi 2](https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=raspberry+pi+) (any computer that can run python will work, this is just what I used)
3. [USB -> Serial Adapter](https://www.amazon.com/TRENDnet-TU-S9-USB-Serial-Converter/dp/B0007T27H8/ref=sr_1_1?ie=UTF8&qid=1474572139&sr=8-1&keywords=TRENDnet+TU-S9+USB+to+Serial+Converter) (not needed if you have a computer with a serial port)
4. [10 foot Serial cord](https://www.amazon.com/StarTech-com-10-Feet-Straight-Through-Serial/dp/B000A7NROO/ref=sr_1_1?ie=UTF8&qid=1474572167&sr=8-1&keywords=10-Feet+Straight+Through+Serial+Cable+-+M%2FF+.) 

If your computer has a built in serial port, you will have to update line 5 to use the correct serial port. `/dev/ttyUSB0` is used when there is a USB serial port. 

# Installation
Aftering hooking everything up and powering it on(I always made sure the Pi was on first before turning on the Monoprice unit) you need to install Python. If you are using a Pi, you should be able to type in these commands to download and install Python.

`sudo apt-get update`

`sudo apt-get install python3-picamera`

After that you can use whatever method you want to download the project (homeAudio.py and instructions.tpl) to the Rasperry Pi. Make sure they are both in the same directory! 

Open a command prompt and browse to the project directory and run

`python homeAudio.py`

That should do it!
  
# Endpoint URLs
*Where 0.0.0.0 is the IP address of your Raspberry Pi *

Instructions:
http://0.0.0.0/

Get Unit Status:
http://0.0.0.0/status

Get Zone Status:
*replace zone below with a number from below. For example, 11 to get Zone 1 on Unit 1.*
http://0.0.0.0/status/(zone)  

Send Command:
http://0.0.0.0/send 


# Available Zones
|         | Unit 1 | Unit 2 | Unit 3 |
| ------- | ------ | ------ | ------ |
| Zone  1 |   11   |   21   |   31   |
| Zone  2 |   12   |   22   |   32   |
| Zone  3 |   13   |   23   |   33   |
| Zone  4 |   14   |   24   |   34   |
| Zone  5 |   15   |   25   |   35   |
| Zone  6 |   16   |   26   |   36   |


# Sending Commands

To send a command you need to send a POST request to the url with a json payload. This payload is pretty simple, for example, to turn on Zone 1, I would send:

`{ command:11PR01 }`

There are many different ways to send a request. To test it out, you can download a utility called curl and send the commands from a command prompt like this:

`curl -i -X POST -d '{"command":"11PR01"}' http://0.0.0.0/send`

###Example Commands

The first number in each command is the unit you are targeting. The master unit is always 1. If you had a 2nd or third slave unit, you would substitute the first 1 with a 2 or 3 depending on which unit you wanted to control.

The second number in each command is the zone you are targeting. You can substitute the 1 for a 2,3,4,5 or 6 to reach all the zones on a particular unit.

In the examples below, I am always targeting Unit 1 Zone 1. If you wanted to target, say, Unit 1 Zone 4, the commands would start with 14 instead of 11.

###Toggle Power

11PR00 - Turn Off Zone 1

11PR01 - Turn On Zone 1

###Change Sources

11CH01 - Change Zone 1 to Source 1

11CH02 - Change Zone 1 to Source 2

11CH03 - Change Zone 1 to Source 3

11CH04 - Change Zone 1 to Source 4

11CH05 - Change Zone 1 to Source 5

11CH06 - Change Zone 1 to Source 6

###Adjust Audio

*For audio adjustments, the last two numbers can range from 00 to 09*

11VO03 Change Volume to 3

11BS04 Change Bass to 4

11TR06 Change Treble to 6
