{ lib, config, ... }:
let
  cfg = config.features.lsp;
in
{
  options.features.lsp.enable = lib.mkEnableOption "Claude Code LSP integration hint (writes a stub at .claude/.lsp.json on first shell entry if absent).";

  config = lib.mkIf cfg.enable {
    enterShell = ''
      if [ ! -e .claude/.lsp.json ] && [ -e .claude ]; then
        :
      fi
    '';
  };
}
