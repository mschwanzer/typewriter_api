#!/usr/bin/python

########### Purpose
# Script runs on Raspberry Pi on Typewriter Table
# Connects 3 GPIOs to Shift Registers on Control Board 0
# Optional: WIFI Modul (<10$), 
# USB Webcam uploading Photos of done Tweet to Webserver, providing Live Stream

########### Script 
# Checks after each job printed for new job from web print queue => just text
# Sets cartridge returns and new lines when appropiate 
# Sends proper command for key to shift register

########### Config 
# User and Password for AUTH
# Wait time before asking for next print job
# Line Width in Chars for paper type

username = "admin"
password = "password"
line_width = 3 # chars that fit on paper line

import time
import urllib2
#import RPi.GPIO as io 


# Auth Stuff to get latest job
password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
top_level_url = "http://lepetiteprintshop.com/"
password_mgr.add_password(None, top_level_url, username, password)
handler = urllib2.HTTPBasicAuthHandler(password_mgr)
opener = urllib2.build_opener(handler)
urllib2.install_opener(opener)

response = urllib2.urlopen('http://lepetiteprintshop.com/jobs/show.text')
content = response.read()

pos = 0
while pos < content.__len__() : 
  # TODO NO MATTER where Cartrige is, Pull it to the other side and give me a new line
  print(content[pos])
  # TODO if content[pos] == a : signal to shift registers that equals "10000000" and then set 000000 again after delay
  pos += 1
  if pos % line_width == 0 : 
    print("--------------- NEW LINE + Cartrige Return -------------")
    # DELAY FOR A SEC


# io.setup(power_pin, io.OUT)
# io.output(power_pin, false)
# io.output(power_pin, true)
# time.sleep(0.3)
# io.output(power_pin, false)
# time.sleep(0.3)
    