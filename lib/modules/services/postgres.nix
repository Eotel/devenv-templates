{ lib, config, pkgs, ... }:
let
  cfg = config.features.services.postgres;
in
{
  options.features.services.postgres = {
    enable = lib.mkEnableOption "PostgreSQL: psycopg/libpq build environment + (optional) postgres process.";

    runService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to start a local postgres process via devenv services.";
    };

    initialDatabases = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      default = [ { name = "app"; } ];
      description = "Databases created on first launch.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      postgresql
      libpq
    ];

    env.LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.libpq ];

    services.postgres = lib.mkIf cfg.runService {
      enable = true;
      initialDatabases = cfg.initialDatabases;
    };
  };
}
