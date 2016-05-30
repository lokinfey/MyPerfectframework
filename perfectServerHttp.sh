do_start() {  
  cd www/var/  
  perfectserverhttp &  
}  
  
do_stop() {  
  pkill -f perfectserverhttp  
}  
  
case "$1" in  
  start)  
    do_start  
    ;;  
  stop)  
    do_stop  
    ;;  
  restart)  
    do_stop  
    do_start  
    ;;  
esac  
  
exit 0