{ lib, config, ... }:
let
  cfg = config.features.git-hooks;
in
{
  options.features.git-hooks = {
    enable = lib.mkEnableOption "devenv git-hooks (pre-commit) integration.";

    nixfmt = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Run nixfmt-rfc-style on .nix files at commit time.";
    };
  };

  config = lib.mkIf cfg.enable {
    git-hooks.hooks = {
      nixfmt-rfc-style.enable = cfg.nixfmt;
    };
  };
}
