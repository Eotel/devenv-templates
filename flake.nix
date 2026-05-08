{
  description = "Eotel's devenv templates: per-language scaffolds with modular feature toggles (direnv, delta, treefmt, git-hooks, services).";

  outputs = _: {
    templates = {
      python = {
        path = ./templates/python;
        description = "Python devenv (uv, ruff, basedpyright, treefmt, git-hooks).";
        welcomeText = ''
          # Python devenv

          Edit `devenv.nix` to toggle features under `features = { ... };`.
          Then `direnv allow` (or `devenv shell`) to enter the environment.
          Run `uv sync` to install dependencies.
        '';
      };

      "python+django" = {
        path = ./templates/python+django;
        description = "Python + Django + DRF + Postgres (uv, ruff, basedpyright).";
        welcomeText = ''
          # Python + Django devenv

          Postgres is enabled by default (`features.services.postgres.enable = true`).
          Edit `devenv.nix` to toggle features. Run `uv sync`, then `direnv allow`.
        '';
      };

      "python+fastapi" = {
        path = ./templates/python+fastapi;
        description = "Python + FastAPI (uv, ruff, basedpyright, pydantic-mypy).";
        welcomeText = ''
          # Python + FastAPI devenv

          Edit `devenv.nix` to toggle features. Run `uv sync`, then `direnv allow`.
        '';
      };

      "python+flask" = {
        path = ./templates/python+flask;
        description = "Python + Flask + SQLAlchemy (uv, ruff, basedpyright).";
        welcomeText = ''
          # Python + Flask devenv

          Edit `devenv.nix` to toggle features. Run `uv sync`, then `direnv allow`.
        '';
      };
    };

    lib.modules = {
      direnv = ./lib/modules/direnv.nix;
      delta = ./lib/modules/delta.nix;
      treefmt = ./lib/modules/treefmt.nix;
      git-hooks = ./lib/modules/git-hooks.nix;
      lsp = ./lib/modules/lsp.nix;
      strict-types = ./lib/modules/strict-types.nix;
      services = {
        postgres = ./lib/modules/services/postgres.nix;
        mysql = ./lib/modules/services/mysql.nix;
        redis = ./lib/modules/services/redis.nix;
        sqlite = ./lib/modules/services/sqlite.nix;
      };
    };
  };
}
