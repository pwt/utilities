#!/usr/bin/env bash

if [ $# != 2 ]
then
    echo "Usage:" $0 "<Host_or_IP> <Delay_between_pings_(s)>"
    exit
fi
HOST=$1
SLEEP=$2

STATE="NEW"
OLDSTATE="NEW"
echo $(date "+%Y-%m-%d : %H:%M:%S :") "Starting pings to" $HOST", waiting" $SLEEP"s between pings"
while true
do
    ping -c 1 -W 3 $HOST > /dev/null
    if [ $? == 0 ]
    then
        STATE="UP"
    else
        STATE="DOWN"
    fi
    if [ $STATE != $OLDSTATE ]
    then
        echo $(date "+%Y-%m-%d @ %H:%M:%S :") $HOST "is" $STATE
        OLDSTATE=$STATE
    fi
    sleep $SLEEP
done
