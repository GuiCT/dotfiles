# Put this in ~/.config/fish/functions/fish_prompt.fish 
# or directly in ~/.config/fish/config.fish

function fish_prompt
    # Capture the status code of the last command immediately
    set -l last_status $status

    # 1. Handle Error Code Description
    # We use 'string' operations instead of grep/cut for a more "fishy" approach
    set -l code_description "UNKNOWN"
    if test -f ~/error_codes
        set -l match (grep -e "^$last_status=" ~/error_codes)
        if test -n "$match"
            set -l parts (string split "=" $match)
	    set code_description "$parts[2]"
        end
    end

    # 2. Check for Git
    set -l git_indicator ""
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set git_indicator "; G"
    end

    # 3. Define Colors (using fish names for readability)
    set -l white (set_color normal)
    set -l red_u (set_color -u red)
    set -l green_u (set_color -u green)
    set -l purple_bg (set_color white -b magenta) # fish uses magenta for purple
    set -l normal (set_color normal)

    # 4. Print the Prompt
    # Line 1: [$USER; TIME] (PWD; G)
    printf "%s[%s%s%s; %s%s%s] (%s%s)\n" \
        $white $red_u "$USER" $white \
        $green_u (date '+%H:%M:%S') $white \
        (pwd) "$git_indicator"

    # Line 2: (STATUS) [DESC] ->
    printf "%s(%03d) [%s]%s ↣ " \
        $purple_bg $last_status "$code_description" $normal
end

# To handle your sourced files:
# source ~/set-envs
# source ~/.set-mise
