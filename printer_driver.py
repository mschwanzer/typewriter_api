#!/usr/bin/python

########### Purpose
# Script runs on Raspberry Pi on Typewriter Table
# Connects 3 GPIOs to Shift Registers on Control Board 0
# TODO: USB Webcam uploading Photos of done Tweet to Webserver, providing Live Stream

########### Script 
# Checks after each job printed for new job from web print queue => just text
# TODO Sets cartridge returns and new lines when appropiate 
# TODO Sends proper command for key to shift register

########### Config 
# User and Password for AUTH
# Wait time before asking for next print job
# Line Width in Chars for paper type

username = "admin"
password = "password"
line_width = 3 # chars that fit on paper line
wait_time = 5 # seconds to wait if no job was around



################ Libraries 
import time
import urllib2
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)

################ Setup 
# Define MODES
ALL  = -1
HIGH = 1
LOW  = 0

# Define pins
_SER_pin   = 25    #pin 14 on the 75HC595
_RCLK_pin  = 24    #pin 12 on the 75HC595
_SRCLK_pin = 23   #pin 11 on the 75HC595

# is used to store states of all pins
_registers = list()

#How many of the shift registers - change this
_number_of_shiftregisters = 2


################ Auth Stuff to get latest job
password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
top_level_url = "http://lepetiteprintshop.com/"
top_level_url = "http://localhost:3000/"
password_mgr.add_password(None, top_level_url, username, password)
handler = urllib2.HTTPBasicAuthHandler(password_mgr)
opener = urllib2.build_opener(handler)
urllib2.install_opener(opener)


################ Printing Jobs
while True: 
  response = urllib2.urlopen('http://lepetiteprintshop.com/jobs/lineup.text')
  content = response.read()
  if content == 'NULL':
    time.sleep(wait_time)
    print("NOTHING TO DO HERE! Taking a break.")
  else:
    pos = 0
    while pos < content.__len__() : 
      # TODO NO MATTER where Cartrige is, Pull it to the other side and give me a new line
      print(content[pos])
      # TODO if content[pos] == a : signal to shift registers that equals "10000000" and then set 000000 again after delay
      pos += 1
      if pos % line_width == 0 : 
        print("--------------- NEW LINE + Cartrige Return -------------")
        # DELAY FOR A SEC

    i = 0
    while i < 11 : 
        
        if i == 10:
            digitalWrite(i, HIGH)
            delay(0.15)
            digitalWrite(i, LOW)
            delay(0.15)
        else:
            digitalWrite(i, HIGH)
            delay(0.2)
            digitalWrite(i, LOW)
            delay(0.2)   
        i +=1
        
    digitalWrite(ALL, LOW)  

################ Shift Register Functionality 

def pinsSetup(**kwargs):
    global _SER_pin, _RCLK_pin, _SRCLK_pin

    custompins = 0
    serpin = _SER_pin
    rclkpin = _RCLK_pin
    srclkpin = _SRCLK_pin

    if len(kwargs) > 0:
        custompins = 1

        _SER_pin = kwargs.get('ser', _SER_pin)
        _RCLK_pin = kwargs.get('rclk', _RCLK_pin)
        _SRCLK_pin = kwargs.get('srclk', _SRCLK_pin)

    if custompins:
        if _SER_pin != serpin or _RCLK_pin != rclkpin or _SRCLK_pin != srclkpin:
            GPIO.setwarnings(True)
    else:
        GPIO.setwarnings(False)

    GPIO.setup(_SER_pin, GPIO.OUT)
    GPIO.setup(_RCLK_pin, GPIO.OUT)
    GPIO.setup(_SRCLK_pin, GPIO.OUT)

def startupMode(mode, execute = False):
    if isinstance(mode, int):
        if mode is HIGH or mode is LOW:
            _all(mode, execute)
        else:
            raise ValueError("The mode can be only HIGH or LOW or Dictionary with specific pins and modes")
    elif isinstance(mode, dict):
        for pin, mode in mode.iteritems():
            _setPin(pin, mode)
        if execute:
            _execute()
    else:
        raise ValueError("The mode can be only HIGH or LOW or Dictionary with specific pins and modes")


def shiftRegisters(num):
    global _number_of_shiftregisters
    _number_of_shiftregisters = num
    _all(LOW)

def digitalWrite(pin, mode):
    if pin == ALL:
        _all(mode)
    else:
        if len(_registers) == 0:
            _all(LOW)

        _setPin(pin, mode)
    _execute()

def delay(millis):
    millis_to_seconds = millis
    return sleep(millis_to_seconds)

def _all_pins():
    return _number_of_shiftregisters * 8

def _all(mode, execute = True):
    all_shr = _all_pins()

    for pin in range(0, all_shr):
        _setPin(pin, mode)
    if execute:
        _execute()

    return _registers

def _setPin(pin, mode):
    try:
        _registers[pin] = mode
    except IndexError:
        _registers.insert(pin, mode)

def _execute():
    all_pins = _all_pins()
    GPIO.output(_RCLK_pin, GPIO.LOW)

    for pin in range(all_pins -1, -1, -1):
        GPIO.output(_SRCLK_pin, GPIO.LOW)

        pin_mode = _registers[pin]

        GPIO.output(_SER_pin, pin_mode)
        GPIO.output(_SRCLK_pin, GPIO.HIGH)

    GPIO.output(_RCLK_pin, GPIO.HIGH)

pinsSetup()
    