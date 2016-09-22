<!DOCTYPE html>
<html>
<head>
<title>Home Audio API</title>
<style>
th{font-weight: normal;}
caption{ font-weight: bold;}
</style>
</head>
<body>

<h1> Home Audio API </h1>

<h3>What is this script</h3>
<p>In the fall of 2015 I purchased a whole home audio controller from monoprice. I wanted to control it from my phone. I taught myself Swift and released an app called Home Audio. It required a special ethernet -> serial adapter to hookup the monoprice's serial adapter to the network, but it worked great. I had a Raspberry Pi 2 sitting in a box looking for a project, so I decided to create a simple Web API for a cheaper option.</p>

<p>Please be aware, this is not the fastest thing in the world. We're going across a serial port. To refresh the status of everything can take some time. Pushing commands should be pretty quick though, I've gotten responses in 1-2 seconds.</p>

<h3>Requirements</h3>

<p>To actually use this script, you need a few things:</p>
<ul>
    <li><a href="http://www.monoprice.com/product?p_id=10761">Monoprice Whole Home Audio Controller</a></li>
    <li><a href="https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=raspberry+pi+">Raspberry Pi 2</a> (any computer that can run python will work, this is just what I used)</li>
    <li><a href="https://www.amazon.com/TRENDnet-TU-S9-USB-Serial-Converter/dp/B0007T27H8/ref=sr_1_1?ie=UTF8&qid=1474572139&sr=8-1&keywords=TRENDnet+TU-S9+USB+to+Serial+Converter">USB -> Serial Adapter</a> (not needed if you have a computer with a serial port)</li>
    <li><a href="https://www.amazon.com/StarTech-com-10-Feet-Straight-Through-Serial/dp/B000A7NROO/ref=sr_1_1?ie=UTF8&qid=1474572167&sr=8-1&keywords=10-Feet+Straight+Through+Serial+Cable+-+M%2FF+.">10 foot Serial cord</a></li>
</ul>

<p>If your computer has a built in serial port, you will have to update line 5 to use the correct serial port. /dev/ttyUSB0 is used when there is a USB serial port.</p>

<h3>Installation</h3>

<p>Aftering hooking everything up and powering it on(I always made sure the Pi was on first before turning on the Monoprice unit) you need to install Python. If you are using a Pi, you should be able to type in these commands to download and install Python.</p>

<code>sudo apt-get update</code><br><br>

<code>sudo apt-get install python3-picamera</code>

<p>After that you can use whatever method you want to download the project (homeAudio.py and instructions.tpl) to the Rasperry Pi. Make sure they are both in the same directory!</p>

<p>Open a command prompt and browse to the project directory and run</p>

<code>python homeAudio.py</code>

<p>That should do it!</p>

<h3>Endpoint URLs</h3>
<p>Get Unit Status:<br><a href="http://{{ipaddress}}/status">http://{{ipaddress}}/status</a></p>
<p>Get Zone Status:<br><a href="http://{{ipaddress}}/status/(zone)">http://{{ipaddress}}/status/(zone)</a> <br/>
<p>Send Command:<br><a href="http://{{ipaddress}}/send">http://{{ipaddress}}/send</a>
<br><br><br>

<h3>Available Zones</H3>
<table>
  <tr>
    <th></th>
    <th><b>Unit 1</b></th>
    <th><b>Unit 2</b></th>
    <th><b>Unit 3</b></th>
  </tr>
  <tr>
    <th><b>Zone 1</b></th>
    <th>11</th>
    <th>21</th>
    <th>31</th>
  </tr>
  <tr>
    <th><b>Zone 2</b></th>
    <th>12</th>
    <th>22</th>
    <th>32</th>
  </tr>
  <tr>
    <th><b>Zone 3</b></th>
    <th>13</th>
    <th>23</th>
    <th>33</th>
  </tr>
  <tr>
    <th><b>Zone 4</b></th>
    <th>14</th>
    <th>24</th>
    <th>34</th>
  </tr>
  <tr>
    <th><b>Zone 5</b></th>
    <th>15</th>
    <th>25</th>
    <th>35</th>
  </tr>
  <tr>
    <th><b>Zone 6</b></th>
    <th>16</th>
    <th>26</th>
    <th>36</th>
  </tr>
</table>

<H3>Sending Commands</H3>
To send a command you need to send a POST request to the url with a json payload. This payload is pretty simple, for example, to turn on Zone 1, I would send:<br><br>
<code>{ command:11PR01 }</code><br><br>

There are many different ways to send a request. To test it out, you can download a utility called curl and send the commands from a command prompt like this:<br><br>

<code>curl -i -X POST -d '{"command":"11PR01"}' http://{{ipaddress}}/send</code>

<H3>Example Commands</H3>
The first number in each command is the unit you are targeting. The master unit is always 1. If you had a 2nd or third slave unit, you would substitute the first 1 with a 2 or 3 depending on which unit you wanted to control.<br>
<br>
The second number in each command is the zone you are targeting. You can substitute the 1 for a 2,3,4,5 or 6 to reach all the zones on a particular unit.<br>
<br>
In the examples below, I am always targeting Unit 1 Zone 1. If you wanted to target, say, Unit 1 Zone 4, the commands would start with 14 instead of 11.<br><br>

<b>Toggle Power</b>
<ul>
<li>11PR00 - Turn Off Zone 1</li>
<li>11PR01 - Turn On Zone 1</li>

</ul>

<b>Change Sources</b>
<ul>
<li>11CH01 - Change Zone 1 to Source 1</li>
<li>11CH02 - Change Zone 1 to Source 2</li>
<li>11CH03 - Change Zone 1 to Source 3</li>
<li>11CH04 - Change Zone 1 to Source 4</li>
<li>11CH05 - Change Zone 1 to Source 5</li>
<li>11CH06 - Change Zone 1 to Source 6</li>
</ul>

<b>Adjust Audio</b><br>
For audio adjustments, the last two numbers can range from 00 to 09
<ul>
<li>11VO03  Change Volume to 3</li>
<li>11BS04  Change Bass to 4</li>
<li>11TR06  Change Treble to 6</li>
</ul>

</body>
</html>


