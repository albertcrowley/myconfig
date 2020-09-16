export DISPLAY=192.168.33.1:0.0
export CRYPTIFY=Blue-Cast-1-Heavy-Bird
export PAGER='less -S'
export PGHOST=localhost
export PGDATABASE=srt
export PGUSER=circleci
export PGPASSWORD=srtpass
alias docker="sudo docker"
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS     

alias cvsdiff='cvs diff . 2>&1 | grep -v Diffing'
