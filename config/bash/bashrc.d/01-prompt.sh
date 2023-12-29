#!/bin/bash
if [ -n "$SSH_CLIENT" ]; then
	export PS1="\u@\h \[\e[1;32m\]\\w \\$\[\e[0m\] "
elif [ -f /run/.toolboxenv ]; then
	export PS1="toolbox \[\e[1;32m\]\\w \\$\[\e[0m\] "
else 
	export PS1="\[\e[1;32m\]\w \\$\[\e[0m\] "
fi
