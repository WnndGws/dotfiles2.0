#!/bin/python
# -*- coding: utf-8 -*-
""" Is used to display weather for current location in polybar """

import os
import configparser
import datetime
import json
import requests
import time

CONFIG = configparser.ConfigParser()
FILEDIR = os.path.dirname(__file__)
CONFIG.read(FILEDIR + '/.weather.ini')

CITY = CONFIG['SETTINGS']['CITY']
API_KEY = CONFIG['SETTINGS']['API_KEY']
UNITS = "Metric"
UNIT_KEY = "C"
NOW = int(time.time())

DATAFILE = (FILEDIR + '/.weather_data.txt')
file_age = NOW - int(os.stat(DATAFILE).st_mtime)

if file_age > 3600:
    try:
        REQ = requests.get(f"https://api.openweathermap.org/data/2.5/weather?id={CITY}&appid={API_KEY}&units={UNITS}")
        if REQ.status_code == 200:
            CURRENT = REQ.json()["weather"][0]["description"].capitalize()
            TEMP = int(REQ.json()["main"]["temp"])
            SUNRISE = REQ.json()["sys"]["sunrise"]
            SUNRISE_TOMORROW = REQ.json()["sys"]["sunrise"] + (24*3600)
            SUNSET = REQ.json()["sys"]["sunset"]
        with open(DATAFILE, "w") as f:
            json.dump({
                "CURRENT": CURRENT,
                "TEMP": TEMP,
                "SUNRISE": SUNRISE,
                "SUNRISE_TOMORROW": SUNRISE_TOMORROW,
                "SUNSET": SUNSET
            }, f)
        #else:
            #CURRENT = "Unknown"
            #TEMP = "Unknown"
            #SUNRISE = "Unknown"
            #SUNRISE_TOMORROW = "Unknown"
            #SUNSET = "Unknown"
    except requests.exceptions.RequestException:
        #CURRENT = "Unknown"
        #TEMP = "Unknown"
        #SUNRISE = "Unknown"
        #SUNRISE_TOMORROW = "Unknown"
        #SUNSET = "Unknown"
        pass

DATA = json.load(open(DATAFILE, "r"))
SUNRISE = int(DATA["SUNRISE"])
SUNRISE_TOMORROW = int(DATA["SUNRISE_TOMORROW"])
SUNSET = int(DATA["SUNSET"])

if SUNRISE < NOW < SUNSET:
    if time.strftime('%H', time.gmtime(SUNSET - NOW)) == '00':
        print(f" SET in {time.strftime('%Mm', time.gmtime(SUNSET - NOW))} at {datetime.datetime.fromtimestamp(SUNSET).strftime('%H:%M')}")
    else:
        print(f" SET in {time.strftime('%Hh', time.gmtime(SUNSET - NOW))} at {datetime.datetime.fromtimestamp(SUNSET).strftime('%H:%M')}")
else:
    print(f" RISE in {time.strftime('%Hh', time.gmtime(SUNRISE_TOMORROW - NOW))} at {datetime.datetime.fromtimestamp(SUNRISE_TOMORROW).strftime('%H:%M')}")
