# SDKMAN wrapper function for Nushell
# This function wraps the bash sdkman scripts to make them available in nushell

def sdk [command?: string, ...rest: string] {
    let sdkman_dir = $env.SDKMAN_DIR
    
    # If no command provided, show help
    if ($command | is-empty) {
        bash -c $"source ($sdkman_dir)/bin/sdkman-init.sh && sdk"
        return
    }
    
    # Translate shortcut commands to full names
    let full_command = match $command {
        "l" => "list",
        "ls" => "list",
        "v" => "version",
        "u" => "use",
        "i" => "install",
        "rm" => "uninstall",
        "c" => "current",
        "ug" => "upgrade",
        "d" => "default",
        "h" => "home",
        "e" => "env",
        _ => $command
    }
    
    # Build the command with all arguments
    let args = if ($rest | is-empty) {
        $full_command
    } else {
        $"($full_command) ($rest | str join ' ')"
    }
    
    # Execute the sdk command via bash with proper initialization
    bash -c $"source ($sdkman_dir)/bin/sdkman-init.sh && sdk ($args)"
}
