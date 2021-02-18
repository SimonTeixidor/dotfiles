source ~/.bashrc
[ $(tty) == "/dev/tty1" ] && (pgrep Xorg >/dev/null || xinit)
