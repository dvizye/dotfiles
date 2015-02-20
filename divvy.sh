SERVICE="Divvy"
if ! ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    /Applications/Divvy.app/Contents/MacOS/Divvy > /dev/null 2>&1 &
fi
