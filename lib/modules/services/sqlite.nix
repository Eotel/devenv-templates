{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.services.sqlite;
in
{
  options.features.services.sqlite.enable =
    lib.mkEnableOption "SQLite CLI in PATH (Python's sqlite3 stdlib needs no extra build env).";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.sqlite ];
  };
}
