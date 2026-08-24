function fish_prompt -d "Write out the prompt"
    printf '%s@%s %s%s%s > ' $hostname $USER \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    starship init fish | source

    if test -f ~/.cache/wal/sequences
        cat ~/.cache/wal/sequences
    end
end

# Created by `pipx` on 2026-06-12 19:57:10
set PATH $PATH /home/murcas/.local/bin

# Make neovim use my configs even as sudo
set -Ux SUDO_EDITOR nvim

# get vulkansdk started -- Not installed on Murc-LAB
# source /opt/vulkansdk/1.4.357.1/setup-env.fish 
