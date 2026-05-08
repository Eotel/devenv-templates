{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [
    "${inputs.devenv-templates}/lib/modules/direnv.nix"
    "${inputs.devenv-templates}/lib/modules/delta.nix"
    "${inputs.devenv-templates}/lib/modules/treefmt.nix"
    "${inputs.devenv-templates}/lib/modules/git-hooks.nix"
    "${inputs.devenv-templates}/lib/modules/lsp.nix"
    "${inputs.devenv-templates}/lib/modules/strict-types.nix"
    "${inputs.devenv-templates}/lib/modules/services/postgres.nix"
    "${inputs.devenv-templates}/lib/modules/services/mysql.nix"
    "${inputs.devenv-templates}/lib/modules/services/redis.nix"
    "${inputs.devenv-templates}/lib/modules/services/sqlite.nix"
  ];

  features = {
    direnv.enable = true;
    delta.enable = true;
    treefmt.enable = true;
    git-hooks.enable = true;
    lsp.enable = false;
    strict-types.enable = false;
    services.postgres.enable = false;
    services.mysql.enable = false;
    services.redis.enable = false;
    services.sqlite.enable = true;
  };

  languages.python = {
    enable = true;
    version = "3.12";
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  packages = [
    pkgs.ruff
    pkgs.basedpyright
  ];

  git-hooks.hooks = {
    ruff.enable = true;
    ruff-format.enable = true;
  };

  enterShell = ''
    echo ""
    echo "Python + Flask devenv ready"
    echo "  flask --app app run --debug   - start dev server"
    echo ""
  '';
}
