# ansi-escape.fish
Print ansi escape with fish

## Installation

```sh
fisher install dangh/ansi-escape.fish
```

## Usage

```sh
# print bold yellow text
yellow --bold text

# print black text on bright white background
black (brwhite --background text)

# print italic underline text
ansi-escape --italics --underline text
# or
italic (underline text)
```
