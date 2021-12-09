#!/usr/bin/env zsh

compdef _pash pash

function _pash() {
  local line state
  _arguments -C "1: :(add copy del list show tree)" '*::arg:->args'
  case $state in
    (args)
      case $line[1] in
        add|copy|del|show)
          _arguments "1: :($(pash list 2>/dev/null | tr '\n' ' '))"
          ;;
      esac
      ;;
  esac
}
