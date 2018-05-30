#!/usr/bin/python3
##

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

DATA = json.load(open(DATAFILE, "r"))
CURRENT = DATA["CURRENT"]
TEMP = DATA["TEMP"]

icons_dict = {
    "thunderstorm": str(""),
    "drizzle": str(""),
    "rain": str(""),
    "clear": str(""),
    "clouds": str(""),
}
lookup_val = next((k for k in icons_dict if k in CURRENT.lower()), None)
ICON = icons_dict.get(lookup_val, "")

print(f"{ICON} {CURRENT}, {TEMP}°{UNIT_KEY}")
