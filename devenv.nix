{ ... }:

{
  imports = [
    ./lib/modules/treefmt.nix
    ./lib/modules/git-hooks.nix
  ];

  features = {
    treefmt.enable = true;
    git-hooks = {
      enable = true;
      nixfmt = true;
      deadnix = true;
      statix = true;
      endOfFileFixer = true;
      trailingWhitespace = true;
      gitleaks = true;
    };
  };

  enterShell = ''
    echo ""
    echo "devenv-templates (dogfooding shell)"
    echo "  treefmt + nixfmt + deadnix + statix"
    echo ""
  '';
}
