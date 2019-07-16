
if [[ "$(uname -s)" == "Darwin" ]]; then
    set_iterm_profile() {
        val=$(osascript -e "tell application \"System Events\" to tell appearance preferences to set res to dark mode" 2>/dev/null)
        if [[ $val == "false" ]]; then
            iterm_profile_toggle
        fi
    }

    iterm_profile_toggle() {
        if [[ $ITERM_PROFILE == "Light" ]]; then
            echo -ne "\033]50;SetProfile=Dark\a"
            export ITERM_PROFILE="Dark"
        else
            echo -ne "\033]50;SetProfile=Light\a"
            export ITERM_PROFILE="Light"
        fi
    }

    set_iterm_profile
fi

