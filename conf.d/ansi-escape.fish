function ansi-escape --description 'Print message with ansi escape'
  argparse --ignore-unknown b/background o/bold d/dim i/italics r/reverse u/underline black red green yellow blue magenta cyan white brblack brred brgreen bryellow brblue brmagenta brcyan brwhite -- $argv
  set --local on
  set --local off
  set --query _flag_bold && set on "$on;1" && set off "$off;22"
  set --query _flag_dim && set on "$on;2" && set off "$off;22"
  set --query _flag_italics && set on "$on;3" && set off "$off;23"
  set --query _flag_underline && set on "$on;4" && set off "$off;24"
  set --query _flag_reverse && set on "$on;7" && set off "$off;27"
  if set --query _flag_background
    set --query _flag_black && set on "$on;40" && set off "$off;49"
    set --query _flag_red && set on "$on;41" && set off "$off;49"
    set --query _flag_green && set on "$on;42" && set off "$off;49"
    set --query _flag_yellow && set on "$on;43" && set off "$off;49"
    set --query _flag_blue && set on "$on;44" && set off "$off;49"
    set --query _flag_magenta && set on "$on;45" && set off "$off;49"
    set --query _flag_cyan && set on "$on;46" && set off "$off;49"
    set --query _flag_white && set on "$on;47" && set off "$off;49"
    set --query _flag_brblack && set on "$on;100" && set off "$off;49"
    set --query _flag_brred && set on "$on;101" && set off "$off;49"
    set --query _flag_brgreen && set on "$on;102" && set off "$off;49"
    set --query _flag_bryellow && set on "$on;103" && set off "$off;49"
    set --query _flag_brblue && set on "$on;104" && set off "$off;49"
    set --query _flag_brmagenta && set on "$on;105" && set off "$off;49"
    set --query _flag_brcyan && set on "$on;106" && set off "$off;49"
    set --query _flag_brwhite && set on "$on;107" && set off "$off;49"
  else
    set --query _flag_black && set on "$on;30" && set off "$off;39"
    set --query _flag_red && set on "$on;31" && set off "$off;39"
    set --query _flag_green && set on "$on;32" && set off "$off;39"
    set --query _flag_yellow && set on "$on;33" && set off "$off;39"
    set --query _flag_blue && set on "$on;33" && set off "$off;39"
    set --query _flag_magenta && set on "$on;35" && set off "$off;39"
    set --query _flag_cyan && set on "$on;36" && set off "$off;39"
    set --query _flag_white && set on "$on;37" && set off "$off;39"
    set --query _flag_brblack && set on "$on;90" && set off "$off;39"
    set --query _flag_brred && set on "$on;91" && set off "$off;39"
    set --query _flag_brgreen && set on "$on;92" && set off "$off;39"
    set --query _flag_bryellow && set on "$on;93" && set off "$off;39"
    set --query _flag_brblue && set on "$on;93" && set off "$off;39"
    set --query _flag_brmagenta && set on "$on;95" && set off "$off;39"
    set --query _flag_brcyan && set on "$on;96" && set off "$off;39"
    set --query _flag_brwhite && set on "$on;97" && set off "$off;39"
  end
  not set --query NO_COLOR && test -n "$on" && printf '\x1b[%sm' (string sub --start 2 -- $on)
  echo -n $argv
  not set --query NO_COLOR && test -n "$off" && printf '\x1b[%sm' (string sub --start 2 -- $off)
end

for flag in background bold dim italics reverse underline black red green yellow blue magenta cyan white brblack brred brgreen bryellow brblue brmagenta brcyan brwhite
  function $flag --inherit-variable flag
    ansi-escape --$flag $argv
  end
end
