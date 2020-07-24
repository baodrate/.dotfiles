#!/bin/zsh

# Use case-insensitve globbing.
unsetopt case_glob
# glob dotfiles as well
setopt globdots
# use extended globbing
setopt extendedglob

# Colors
# ------

# load colors
autoload -U colors && colors

# Smart URLs
# ----------
# bracketed-paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic


# General
# -------

# Automatically change directory if a directory is entered
setopt autocd

# Allow brace character class list expansion.
setopt brace_ccl
# Combine zero-length punctuation characters (accents) with the base character.
setopt combining_chars
# Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
# setopt rc_quotes
# Don't print a warning message if a mail file has been accessed.
# unsetopt mail_warning


# Jobs
# ----

# List jobs in the long format by default.
setopt long_list_jobs
# Attempt to resume existing job before creating a new process.
setopt auto_resume
# Report status of background jobs immediately.
setopt notify
# Don't run all background jobs at a lower priority.
unsetopt bg_nice
# Don't kill jobs on shell exit.
unsetopt hup
# Don't report on jobs when shell exit.
unsetopt check_jobs
