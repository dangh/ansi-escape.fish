function ansi-escape --description 'Print message with ansi escape'
  argparse --ignore-unknown \
    b/background \
    no-background \
    o/bold d/dim h/hidden i/italics r/reverse s/strikethrough u/underline \
    no-bold no-dim no-hidden no-italics no-reverse no-strikethrough no-underline \
    black red green yellow blue magenta cyan white \
    brblack brred brgreen bryellow brblue brmagenta brcyan brwhite \
    no-color \
    normal -- $argv
  set --query NO_COLOR && printf '%s' $argv && return
  set --local on
  set --local off
  set --query _flag_bold && set --append on 1 && set --append off 22
  set --query _flag_no_bold && set --append on 22
  set --query _flag_dim && set --append on 2 && set --append off 22
  set --query _flag_no_dim && set --append on 22
  set --query _flag_italics && set --append on 3 && set --append off 23
  set --query _flag_no_italics && set --append on 23
  set --query _flag_underline && set --append on 4 && set --append off 24
  set --query _flag_no_underline && set --append on 24
  set --query _flag_reverse && set --append on 7 && set --append off 27
  set --query _flag_no_reverse && set --append on 27
  set --query _flag_hidden && set --append on 8 && set --append off 28
  set --query _flag_no_hidden && set --append on 28
  set --query _flag_strikethrough && set --append on 9 && set --append off 29
  set --query _flag_no_strikethrough && set --append on 29
  if set --query _flag_background
    set --query _flag_black && set --append on 40 && set --append off 49
    set --query _flag_red && set --append on 41 && set --append off 49
    set --query _flag_green && set --append on 42 && set --append off 49
    set --query _flag_yellow && set --append on 43 && set --append off 49
    set --query _flag_blue && set --append on 44 && set --append off 49
    set --query _flag_magenta && set --append on 45 && set --append off 49
    set --query _flag_cyan && set --append on 46 && set --append off 49
    set --query _flag_white && set --append on 47 && set --append off 49
    set --query _flag_brblack && set --append on 100 && set --append off 49
    set --query _flag_brred && set --append on 101 && set --append off 49
    set --query _flag_brgreen && set --append on 102 && set --append off 49
    set --query _flag_bryellow && set --append on 103 && set --append off 49
    set --query _flag_brblue && set --append on 104 && set --append off 49
    set --query _flag_brmagenta && set --append on 105 && set --append off 49
    set --query _flag_brcyan && set --append on 106 && set --append off 49
    set --query _flag_brwhite && set --append on 107 && set --append off 49
  else
    set --query _flag_black && set --append on 30 && set --append off 39
    set --query _flag_red && set --append on 31 && set --append off 39
    set --query _flag_green && set --append on 32 && set --append off 39
    set --query _flag_yellow && set --append on 33 && set --append off 39
    set --query _flag_blue && set --append on 33 && set --append off 39
    set --query _flag_magenta && set --append on 35 && set --append off 39
    set --query _flag_cyan && set --append on 36 && set --append off 39
    set --query _flag_white && set --append on 37 && set --append off 39
    set --query _flag_brblack && set --append on 90 && set --append off 39
    set --query _flag_brred && set --append on 91 && set --append off 39
    set --query _flag_brgreen && set --append on 92 && set --append off 39
    set --query _flag_bryellow && set --append on 93 && set --append off 39
    set --query _flag_brblue && set --append on 93 && set --append off 39
    set --query _flag_brmagenta && set --append on 95 && set --append off 39
    set --query _flag_brcyan && set --append on 96 && set --append off 39
    set --query _flag_brwhite && set --append on 97 && set --append off 39
  end
  set --query _flag_no_color && set --append on 39
  set --query _flag_no_background && set --append on 49
  set --query _flag_normal && set --append on 0
  test -n "$on" && set on \x1b\[(string join \; $on)m
  test -n "$off" && set off \x1b\[(string join \; $off)m
  test -z "$argv" && printf $on && return
  printf '%s%s%s' $on "$argv" $off
end

for flag in background bold dim hidden italics reverse strikethrough underline
  function $flag --inherit-variable flag
    ansi-escape --$flag $argv
  end
  function no-$flag --inherit-variable flag
    ansi-escape --no-$flag $argv
  end
end

for flag in red green yellow blue magenta cyan white
  function $flag --inherit-variable flag
    ansi-escape --$flag $argv
  end
  function br$flag --inherit-variable flag
    ansi-escape --br$flag $argv
  end
end

for flag in no-color normal
  function $flag --inherit-variable flag
    ansi-escape --$flag $argv
  end
end
