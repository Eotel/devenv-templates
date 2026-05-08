{ lib, config, pkgs, ... }:
let
  cfg = config.features.treefmt;
in
{
  options.features.treefmt.enable = lib.mkEnableOption "treefmt + nixfmt-rfc-style (project-level multi-language formatter).";

  config = lib.mkIf cfg.enable {
    packages = [
      pkgs.treefmt
      pkgs.nixfmt-rfc-style
    ];
  };
}
