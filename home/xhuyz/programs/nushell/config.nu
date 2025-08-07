print "\e[6 q"
$env.KOMOREBI_CONFIG_HOME = ($env.Path | prepend 'C:\Users\xhuyz\.config\komorebi')
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = null
$env.ENV_CONVERSIONS = $env.ENV_CONVERSIONS | merge {
    "XDG_DATA_DIRS": {
        from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
        to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
    }
}
$env.config.color_config.filesize = {|x| if $x == 0b { 'dark_gray' } else if $x < 1mb { 'cyan' } else { 'blue' } }
$env.config.color_config.bool = {|x| if $x { 'green' } else { 'light_red' } }
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
alias edit = sudo nvim /etc/nixos/configuration.nix
alias xhuyz = sudo nixos-rebuild switch
alias home = cd ~/.config/home-manager/


