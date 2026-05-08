{ lib, config, ... }:
let
  cfg = config.features.direnv;
in
{
  options.features.direnv.enable = lib.mkEnableOption "direnv auto-activation hint (assumes direnv is installed system-wide).";

  config = lib.mkIf cfg.enable {
    enterShell = ''
      if ! command -v direnv >/dev/null 2>&1; then
        echo "[features.direnv] direnv not found in PATH. Install via nix-darwin/home-manager."
      fi
    '';
  };
}
