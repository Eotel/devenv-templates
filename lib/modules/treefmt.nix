{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.treefmt;
in
{
  options.features.treefmt.enable = lib.mkEnableOption "treefmt + nixfmt (project-level multi-language formatter).";

  config = lib.mkIf cfg.enable {
    packages = [
      pkgs.treefmt
      pkgs.nixfmt
    ];
  };
}
