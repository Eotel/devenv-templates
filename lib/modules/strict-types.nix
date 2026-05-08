{ lib, config, ... }:
let
  cfg = config.features.strict-types;
in
{
  options.features.strict-types.enable = lib.mkEnableOption "strict type-checking marker (consumed by language-specific modules to flip pyrightconfig / mypy / tsconfig to strict).";

  config = lib.mkIf cfg.enable {
    env.DEVENV_FEATURE_STRICT_TYPES = "1";
  };
}
