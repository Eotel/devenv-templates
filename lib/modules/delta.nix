{ lib, config, ... }:
let
  cfg = config.features.delta;
in
{
  options.features.delta.enable = lib.mkEnableOption "delta as local git pager / diff filter (assumes delta is installed system-wide via nix-darwin).";

  config = lib.mkIf cfg.enable {
    enterShell = ''
      if command -v delta >/dev/null 2>&1 && [ -d .git ]; then
        git config --local core.pager 'delta'
        git config --local interactive.diffFilter 'delta --color-only'
        git config --local delta.navigate true
        git config --local delta.line-numbers true
        git config --local merge.conflictstyle diff3
      fi
    '';
  };
}
