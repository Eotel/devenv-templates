{ lib, config, ... }:
let
  cfg = config.features.services.redis;
in
{
  options.features.services.redis = {
    enable = lib.mkEnableOption "Redis service via devenv.";

    runService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to start a local redis process via devenv services.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.redis = lib.mkIf cfg.runService {
      enable = true;
    };
  };
}
