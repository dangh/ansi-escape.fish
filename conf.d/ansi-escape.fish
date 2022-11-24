function ansi-escape -d 'Print message with ansi escape'
  argparse -i \
    b/background \
    no-background \
    o/bold d/dim h/hidden i/italics r/reverse s/strikethrough u/underline \
    no-bold no-dim no-hidden no-italics no-reverse no-strikethrough no-underline \
    black red green yellow blue magenta cyan white \
    brblack brred brgreen bryellow brblue brmagenta brcyan brwhite \
    no-color \
    normal -- $argv
  set -q NO_COLOR && printf '%s' $argv && return
  set -l on
  set -l off
  set -q _flag_bold && set -a on 1 && set -a off 22
  set -q _flag_no_bold && set -a on 22
  set -q _flag_dim && set -a on 2 && set -a off 22
  set -q _flag_no_dim && set -a on 22
  set -q _flag_italics && set -a on 3 && set -a off 23
  set -q _flag_no_italics && set -a on 23
  set -q _flag_underline && set -a on 4 && set -a off 24
  set -q _flag_no_underline && set -a on 24
  set -q _flag_reverse && set -a on 7 && set -a off 27
  set -q _flag_no_reverse && set -a on 27
  set -q _flag_hidden && set -a on 8 && set -a off 28
  set -q _flag_no_hidden && set -a on 28
  set -q _flag_strikethrough && set -a on 9 && set -a off 29
  set -q _flag_no_strikethrough && set -a on 29
  if set -q _flag_background
    set -q _flag_black && set -a on 40 && set -a off 49
    set -q _flag_red && set -a on 41 && set -a off 49
    set -q _flag_green && set -a on 42 && set -a off 49
    set -q _flag_yellow && set -a on 43 && set -a off 49
    set -q _flag_blue && set -a on 44 && set -a off 49
    set -q _flag_magenta && set -a on 45 && set -a off 49
    set -q _flag_cyan && set -a on 46 && set -a off 49
    set -q _flag_white && set -a on 47 && set -a off 49
    set -q _flag_brblack && set -a on 100 && set -a off 49
    set -q _flag_brred && set -a on 101 && set -a off 49
    set -q _flag_brgreen && set -a on 102 && set -a off 49
    set -q _flag_bryellow && set -a on 103 && set -a off 49
    set -q _flag_brblue && set -a on 104 && set -a off 49
    set -q _flag_brmagenta && set -a on 105 && set -a off 49
    set -q _flag_brcyan && set -a on 106 && set -a off 49
    set -q _flag_brwhite && set -a on 107 && set -a off 49
  else
    set -q _flag_black && set -a on 30 && set -a off 39
    set -q _flag_red && set -a on 31 && set -a off 39
    set -q _flag_green && set -a on 32 && set -a off 39
    set -q _flag_yellow && set -a on 33 && set -a off 39
    set -q _flag_blue && set -a on 33 && set -a off 39
    set -q _flag_magenta && set -a on 35 && set -a off 39
    set -q _flag_cyan && set -a on 36 && set -a off 39
    set -q _flag_white && set -a on 37 && set -a off 39
    set -q _flag_brblack && set -a on 90 && set -a off 39
    set -q _flag_brred && set -a on 91 && set -a off 39
    set -q _flag_brgreen && set -a on 92 && set -a off 39
    set -q _flag_bryellow && set -a on 93 && set -a off 39
    set -q _flag_brblue && set -a on 93 && set -a off 39
    set -q _flag_brmagenta && set -a on 95 && set -a off 39
    set -q _flag_brcyan && set -a on 96 && set -a off 39
    set -q _flag_brwhite && set -a on 97 && set -a off 39
  end
  set -q _flag_no_color && set -a on 39
  set -q _flag_no_background && set -a on 49
  set -q _flag_normal && set -a on 0
  test -n "$on" && set on \x1b\[(string join \; $on)m
  test -n "$off" && set off \x1b\[(string join \; $off)m
  set -l text
  begin
    if not isatty stdin
      read -z text
    else
      set text "$argv"
    end
  end
  echo -n $on
  test -n "$text" && echo -n "$text$off"
end

for flag in background bold dim hidden italics reverse strikethrough underline
  function $flag -V flag
    ansi-escape --$flag $argv
  end
  function no-$flag -V flag
    ansi-escape --no-$flag $argv
  end
end

for flag in red green yellow blue magenta cyan white
  function $flag -V flag
    ansi-escape --$flag $argv
  end
  function br$flag -V flag
    ansi-escape --br$flag $argv
  end
end

for flag in no-color normal
  function $flag -V flag
    ansi-escape --$flag $argv
  end
end
