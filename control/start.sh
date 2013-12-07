#!/bin/bash
: >log

echo "trying ttyUSB"

ARDUINO=`ls -1 /dev/ttyUSB* | head -n 1`

if [ "$ARDUINO" = "" ]
then
    echo "trying ttyACM"
    ARDUINO=`ls -1 /dev/ttyACM* | head -n 1`;
fi

if [ "$ARDUINO" = "" ]
then
    echo "no usb module found, exiting";
    exit;
fi

echo "Found ARDUINO at " $ARDUINO


finalize_all(){
   echo >>log in bashtrap
   echo "Exiting..."
   kill $TAILPID
   wait
   exit
}

trap finalize_all INT
#trapping ctrl-c to stop tail -f job

TRUENAME=`readlink -f $0`
DIRNAME=`dirname $TRUENAME`
. $DIRNAME/port_settings $ARDUINO


(echo tail started ; tail -F $ARDUINO) &

TAILPID=$!

echo tail proccess id is $TAILPID 
echo >>log listening
echo listening
cat >>$ARDUINO

echo >>log finished, starting finalization
finalize_all

