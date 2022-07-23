#is_detach=enabled
#use vlc instead of mpv
#video_player () {
#    #check if detach is enabled
#    case "$is_detach" in
      #	#disabled
      #	0) vlc "$@" ;;
      #	#enabled
      #	1) setsid -f vlc "$@" > /dev/null 2>&1 ;;
  #    esac
#}

