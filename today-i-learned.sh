#!/usr/bin/env bash

ask() {
    # $1 : question text
    print_question "$1"
}

kebab_case() {
    printf "$1" | awk '{print tolower($0)}' | sed -e "s/\([,'\"?]\)//g" -e "s/\([ ]\)/-/g"
}

print_in_green() {
    # $1 : print text
    printf "\e[0;32m%b\e[0m" "$1"
    #       |  | | ||   └── \e[0m : Return to plain normal mode
    #       |  | | |└────── %b : Characters from the string argument are printed until the end is reached
    #       |  | | |             and intepret character escapes in backslash notation (see 'man printf')
    #       |  | | └─────── m : Terminate escape sequence
    #       |  | └───────── 32 : Foreground colour green (see table in link given below)
    #       |  └─────────── 0 : Normal text
    #       └────────────── \e[ : Begin escape sequence
    # See http://www.bashguru.com/2010/01/shell-colors-colorizing-shell-scripts.html for more info
    # or see mathiasbynens dotfiles (.bash_prompt) on how he uses tput
}

print_in_yellow() {
    # $1 : print text
    printf "\e[0;33m%b\e[0m" "$1"
    #       |  | | ||   └── \e[0m : Return to plain normal mode
    #       |  | | |└────── %b : Characters from the string argument are printed until the end is reached
    #       |  | | |             and intepret character escapes in backslash notation (see 'man printf')
    #       |  | | └─────── m : Terminate escape sequence
    #       |  | └───────── 33 : Foreground colour yellow (see table in link given below)
    #       |  └─────────── 0 : Normal text
    #       └────────────── \e[ : Begin escape sequence
    # See http://www.bashguru.com/2010/01/shell-colors-colorizing-shell-scripts.html for more info
    # or see mathiasbynens dotfiles (.bash_prompt) on how he uses tput
}

print_question() {
    # $1 : question text
    print_in_yellow "  [?] $1 : "
    read -r
}

print_readme_markdown_list_item_and_section() {
    # $1 = "$TOPIC", $2 = "$TOPIC_KEBAB_CASE", $3 = "$TOPIC_ITEM", $4 = "$TOPIC_ITEM_KEBAB_CASE.md"
    local README_SUBHEADING="### $1"
    local README_LIST_ITEM="- [$3]($2/$4)"
    local README_TOPIC_SECTION="$README_SUBHEADING\n\n$README_LIST_ITEM\n"

    # If directory already exists, then just copy the list item to clipboard
    # Otherwise, copy the section to clipboard
    if [ -d "$TOPIC_KEBAB_CASE" ]; then
        echo "$README_LIST_ITEM" | pbcopy

    else
        printf "$README_TOPIC_SECTION" | pbcopy
    fi

    print_in_green "$README_TOPIC_SECTION"
}

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {
    print_question "What topic did you learn today?"
    declare -r TOPIC="$REPLY"
    declare -r TOPIC_KEBAB_CASE=$(kebab_case "$TOPIC")

    print_question "What did you learn about $TOPIC?"
    declare -r TOPIC_ITEM="$REPLY"
    declare -r TOPIC_ITEM_KEBAB_CASE=$(kebab_case "$TOPIC_ITEM")

    declare -r TOPIC_ITEM_MARKDOWN_TEMPLATE="# $TOPIC_ITEM
"
    # Print markdown text that can be added to READNE.md and copy to clipboard
    print_readme_markdown_list_item_and_section "$TOPIC" "$TOPIC_KEBAB_CASE" "$TOPIC_ITEM" "$TOPIC_ITEM_KEBAB_CASE.md"

    # Create topic directory
    mkdir -p "$TOPIC_KEBAB_CASE"
    # Create topic item markdown folder
    printf "%s" "$TOPIC_ITEM_MARKDOWN_TEMPLATE" >> $TOPIC_KEBAB_CASE/$TOPIC_ITEM_KEBAB_CASE.md
}

main
