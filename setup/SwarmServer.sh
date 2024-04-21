#!/bin/sh
### BEGIN INIT INFO
# Provides:          SwarmServer
# Required-Start:    hostname $local_fs
# Required-Stop:
# Should-Start:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop SwarmServer
# Description:       This script starts/stops SwarmServer
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin
. /lib/init/vars.sh

do_start () {
    sleep 10;sudo /usr/local/bin/swarmserver > /var/tmp/sws.out 2>&1 &
}

do_stop() {
    PID=`pgrep -f swarmserver`

    # Check if the process is running
    if [ -n "$PID" ]; then
        sudo kill -9 $PID
        echo "Swarmserver process killed."
    else
        echo "Swarmserver process not running."
    fi
}

do_status () {
    return 0
}


case "$1" in
  start|"")
    do_start
    ;;
  restart|reload|force-reload)
    do_stop	  
    do_start
    exit 3
    ;;
  stop)
    do_stop	  
    ;;
  status)
    do_status
    exit $?
    ;;
  *)
    echo "Usage: swarmserver [start|stop|status|restart]" >&2
    exit 3
    ;;
esac

:
