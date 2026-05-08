{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.services.mysql;
in
{
  options.features.services.mysql = {
    enable = lib.mkEnableOption "MySQL/MariaDB: mysqlclient build environment + (optional) mysql process.";

    runService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to start a local mysql process via devenv services.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      libmysqlclient
      libmysqlclient.dev
      pkg-config
      openssl
    ];

    env = {
      MYSQLCLIENT_CFLAGS = "-I${pkgs.libmysqlclient.dev}/include/mariadb";
      MYSQLCLIENT_LDFLAGS = "-L${pkgs.libmysqlclient}/lib/mariadb -lmariadb";
    };

    services.mysql = lib.mkIf cfg.runService {
      enable = true;
    };
  };
}
