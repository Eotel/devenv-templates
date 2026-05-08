{
  lib,
  pkgs,
  config,
  ...
}:
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

    deadnix = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Detect unused bindings in .nix files (deadnix).";
    };

    statix = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Lint .nix files for anti-patterns (statix).";
    };

    endOfFileFixer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Ensure files end with a single trailing newline.";
    };

    trailingWhitespace = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Strip trailing whitespace from text files.";
    };

    gitleaks = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Run gitleaks (custom hook) to detect secrets in staged content. Not built into cachix/git-hooks.nix; this module wires it as a custom pre-commit hook backed by pkgs.gitleaks.";
    };
  };

  config = lib.mkIf cfg.enable {
    git-hooks.hooks = {
      nixfmt-rfc-style.enable = cfg.nixfmt;
      deadnix.enable = cfg.deadnix;
      statix.enable = cfg.statix;
      end-of-file-fixer.enable = cfg.endOfFileFixer;
      trim-trailing-whitespace.enable = cfg.trailingWhitespace;
    }
    // lib.optionalAttrs cfg.gitleaks {
      gitleaks = {
        enable = true;
        name = "gitleaks";
        description = "Detect secrets in staged content (gitleaks).";
        entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged --no-banner --redact -v";
        language = "system";
        pass_filenames = false;
      };
    };
  };
}
