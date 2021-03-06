# vim:ft=zsh ts=2 sw=2 sts=2
# Zach's modified agnoster theme. Faster, simpler, prettier? IMHO at least.
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways.
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Special Powerline characters
## ZD
autoload zsh/terminfo
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY BLACK; do
eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  # NOTE: This segment separator character is correct.  In 2012, Powerline changed
  # the code points they use for their special characters. This is the new code point.
  # If this is not working for you, you probably have an old version of the
  # Powerline-patched fonts installed. Download and install the new version.
  # Do not submit PRs to change this unless you have reviewed the Powerline code point
  # history and have new information.
  # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
  # what font the user is viewing this source code in. Do not replace the
  # escape sequence with a single literal character.
  # Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.
  #
  # Zach's additions here to reference some other fun unicode characters
  U_WEDGE=$'\ue0b0'
  SEGMENT_SEPARATOR=$U_WEDGE
  U_ARROWS=$'\u21f6'
  PL_BRANCH_CHAR=$'\ue0a0'
  U_RADIOACTIVE=$'\u2623'
  U_SICKLE=$'\u262d'
  U_SKULL=$'\u2620'
  U_SNAKE=$'\U1F40D'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$U_ARROWS"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Thanks http://thisismecoding.com/multine-agnoster-oh-my-zsh/
prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}
%{%k%F{blue}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi

  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {

  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  GITPROMPT="`git_prompt_info` $PL_BRANCH_CHAR %{$reset_color%}"

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    # setopt promptsubst
 
    echo -n $GITPROMPT
  fi
  gitpromptsize=${#${GITPROMPT}}
  prompt_segment default default
}

prompt_hg() {
  (( $+commands[hg] )) || return
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment red white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_segment green black
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment red black
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment yellow black
        st='±'
      else
        prompt_segment green black
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black "%~%{$reset_color%}"
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  VENVSIZE=0
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    VENV="(`basename $virtualenv_path`)"
    prompt_segment blue red $VENV
    VENVSIZE=${#${VENV}}
  fi
}

##ZD
prompt_right(){
  # return_code="%{$reset_color%} %(?..%{$fg[red]%}%? %{$reset_color%})" # not used for now
  RPROMPT="$U_SNAKE ~$PR_GREEN$CONDA_DEFAULT_ENV$PR_NO_COLOUR~$U_RADIOACTIVE $PR_YELLOW%D{%a,%b %d %H:%M:%S}$PR_NO_COLOUR"

  # echo -n "${(e)PR_FILLBAR}"
  prompt_segment default default "${(e)PR_FILLBAR}"
  echo -n $RPROMPT
}

function right_justify_calc {
    local TERMWIDTH
    #                  | ??  (13 in - 54) or (15 in - 1)
    (( TERMWIDTH = ${COLUMNS} - 66 ))


    ###
    # Truncate the path if it's too long.

    PR_FILLBAR=""
    PR_PWDLEN=""
    setopt promptsubst

    # Git prompt part (dynamic)
    local padding=17
    # Kinda had to do this by eye... confused? Yes. 
    if [[ $gitpromptsize -eq 12 ]] then padding=12; fi

    # Conda environment part (dynamic)
    local plen=58   # regular length of $PROMPT, dynamically changes with conda?
    local ps1len=${#${PS1}}
    local condalen=${#${CONDA_DEFAULT_ENV}}
    local extra="$((ps1len-plen+condalen))"

    # Can extract the conda part maybe? (python35)%{%f%b%k%}$(build_prompt)
    
    local pwdsize=${#${(%):-%~}}
    local statussize=4


    if [[ "$promptsize + $gitpromptsize + $pwdsize" -gt $TERMWIDTH ]]; then
      ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
      PR_FILLBAR="\${(l.(($TERMWIDTH - ($extra + $gitpromptsize + $pwdsize + $statussize) - $padding))...)}"
    fi

}


# Status:
# - was there an error
prompt_status() {
  local symbols
  local bgc
  symbols=()
  CURRENT_BG='NONE'
  if [[ $RETVAL -ne 0 ]]; then
    symbols+="%{%F{black}%}✘ "
    prompt_segment red default "$symbols"
  else
    symbols+="%{%F{black}%}\u2714 "
    prompt_segment green default "$symbols"
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  right_justify_calc
  prompt_right
  prompt_newline
  prompt_end
}
PROMPT='%{%f%b%k%}$(build_prompt)% '
