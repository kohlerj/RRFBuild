#!/bin/bash
if [ -f DuetWebControl-SD.zip ]; then
    echo "Using pre-built DWC"
elif [ -f DuetWebControl/dist/DuetWebControl-SD.zip ]; then
    echo "Using pre-built DWC from dist/"
elif [ -f DuetAPI.xml ]; then
    cp DuetAPI.xml DuetWebControl
    (cd DuetWebControl; npm install; npm run build)
    rm DuetWebControl/DuetAPI.xml
else
    echo "DuetAPI.xml not found"
fi