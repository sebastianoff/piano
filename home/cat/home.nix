{ pkgs, inputs, ... }:
{
  home.username = "cat";
  home.homeDirectory = "/home/cat";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
  };

  programs.helix = {
    enable = true;

    extraPackages = with pkgs; [
      nil
    ];

    settings = {
      theme = "tokyonight";
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

  programs.starship.enable = false;
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_color_normal        white
      set -g fish_color_command       white
      set -g fish_color_param         white
      set -g fish_color_operator      white
      set -g fish_color_quote         white
      set -g fish_color_redirection   white
      set -g fish_color_end           white
      set -g fish_color_valid_path    white

      set -g fish_color_error         brblack

      set -g fish_color_comment       brblack
      set -g fish_color_autosuggestion brblack

      set -g fish_color_selection     white --background=brblack
      set -g fish_color_search_match  white --background=brblack

      set -g fish_pager_color_description brblack
      set -g fish_pager_color_prefix  white
      set -g fish_pager_color_completion white
      set -g fish_pager_color_progress brblack

      set -g fish_greeting
    '';

    functions = {
      fish_prompt = ''
        set -l cwd (prompt_pwd)
        set_color white
        printf "%s" $cwd
        set_color normal
        printf " > "
      '';

      fish_right_prompt = ''
        if test $status -ne 0
          set_color brblack
          printf "[%s]" $status
          set_color normal
        end
      '';
    };
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

  home.packages =
    with pkgs; [
      ripgrep
      fd
      jq
      bat
      tree
      eza
      inputs.zen-browser.packages."${system}".default
    ];
}
