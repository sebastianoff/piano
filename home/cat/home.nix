{ pkgs, inputs, system, ... }:
{
  home.username = "cat";
  home.homeDirectory = "/home/cat";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      enable_audio_bell = "no";
    };
  };

  programs.helix = {
    enable = true;

    extraPackages = with pkgs; [
      nil
    ];

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursor-shape = { normal = "block"; insert = "bar"; select = "underline"; };
        bufferline = "multiple";
        true-color = true;
      };
    };

    # languages.toml
    languages = {
      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
      };

      language = [
        { name = "nix"; language-servers = [ "nil" ]; auto-format = true; }
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      palette = "ctp-mocha";

      add_newline = true;
      format = "$directory$git_branch$zig$nix_shell$cmd_duration$line_break$character";
      right_format = "$status$time";

      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        style = "bold fg:text";
        read_only = " ";
        read_only_style = "fg:peach";
      };

      git_branch = { symbol = " "; style = "bold fg:mauve"; };

      nix_shell = { symbol = " "; format = "via [$symbol$name]($style) "; style = "bold fg:blue"; };
      cmd_duration = { min_time = 500; style = "fg:yellow"; };
      time = { disabled = false; time_format = "%R"; style = "fg:overlay1"; };
      status = { disabled = false; format = "[$symbol]($style) "; symbol = "✖ "; style = "fg:red"; };

      zig = {
        disabled = false;
        symbol = "";
        style = "bold fg:peach";
        format = "via [$symbol $version]($style) ";
        detect_extensions = [ "zig" ];
        detect_files = [ "build.zig" "build.zig.zon" ];
        detect_folders = [ ];
      };

      character = {
        success_symbol = "[](fg:green)";
        error_symbol = "[](fg:red)";
        vicmd_symbol = "[](fg:sky)";
      };

      palettes.ctp-mocha = {
        rosewater = "#f5e0dc";
        flamingo  = "#f2cdcd";
        pink      = "#f5c2e7";
        mauve     = "#cba6f7";
        red       = "#f38ba8";
        maroon    = "#eba0ac";
        peach     = "#fab387";
        yellow    = "#f9e2af";
        green     = "#a6e3a1";
        teal      = "#94e2d5";
        sky       = "#89dceb";
        sapphire  = "#74c7ec";
        blue      = "#89b4fa";
        lavender  = "#b4befe";
        text      = "#cdd6f4";
        subtext1  = "#bac2de";
        subtext0  = "#a6adc8";
        overlay2  = "#9399b2";
        overlay1  = "#7f849c";
        overlay0  = "#6c7086";
        surface2  = "#585b70";
        surface1  = "#45475a";
        surface0  = "#313244";
        base      = "#1e1e2e";
        mantle    = "#181825";
        crust     = "#11111b";
      };
    };
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      ls  = "eza --icons=auto --color=always --group-directories-first";
      ll  = "eza -l --icons=auto --group-directories-first";
      la  = "eza -la --icons=auto --group-directories-first";
      lt  = "eza --tree --icons=auto -L 2";
      grep = "rg";
    };

    functions.devenv = ''
      if test (count $argv) -gt 0
        nix develop $argv -c fish
      else
        nix develop . -c fish
      end
    '';

    interactiveShellInit = ''
      set -g fish_greeting

      set -g fish_color_autosuggestion '#6c7086'    # overlay0
      set -g fish_color_comment       '#6c7086'
      set -g fish_color_selection     'white' --background='#313244'  # surface0
      set -g fish_color_search_match  'white' --background='#313244'
    '';
    functions = { };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Sebastian";
    userEmail = "cheesecakeycat@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    tree
    eza
    inputs.zen-browser.packages."${system}".default
    inputs.apple-fonts.packages."${system}".sf-pro-nerd
    inputs.apple-fonts.packages."${system}".sf-mono-nerd
    steam
  ];
}
