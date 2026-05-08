# Eotel/devenv-templates

Per-language [devenv](https://devenv.sh) scaffolds with modular feature toggles.

## Use a template

```sh
mkdir my-project && cd my-project
nix flake init -t github:Eotel/devenv-templates#python
direnv allow         # or: devenv shell
```

## Available templates

| Name | Description |
|---|---|
| `python` | Python 3.12, uv, ruff, basedpyright, treefmt, git-hooks |
| `python+django` | Python + Django + DRF + Postgres (postgres service ON by default) |
| `python+fastapi` | Python + FastAPI (uvicorn, pydantic, httpx) |
| `python+flask` | Python + Flask + SQLAlchemy + Flask-Migrate |

## Feature toggles

Each template's `devenv.nix` has a `features = { ... };` block at the top:

```nix
features = {
  direnv.enable             = true;   # direnv hint (assumes direnv is installed)
  delta.enable              = true;   # local git pager → delta (assumes delta installed)
  treefmt.enable            = true;   # treefmt + nixfmt for formatting
  git-hooks.enable          = true;   # devenv git-hooks (pre-commit)
  lsp.enable                = false;  # Claude Code LSP integration hint
  strict-types.enable       = false;  # set DEVENV_FEATURE_STRICT_TYPES env
  services.postgres.enable  = false;  # devenv postgres + libpq build env
  services.mysql.enable     = false;  # devenv mysql + mysqlclient build env
  services.redis.enable     = false;  # devenv redis service
  services.sqlite.enable    = true;   # sqlite CLI in PATH
};
```

Each toggle is a small NixOS-style module under [`lib/modules/`](./lib/modules) using `lib.mkEnableOption` + `lib.mkIf`. Templates `import` them via `inputs.devenv-templates`.

## Design notes

- `direnv` / `delta` are **assumed installed system-wide** (e.g. via nix-darwin / home-manager). The modules only wire the project-local config; they do not install the binaries.
- `git-hooks.hooks` is used (not the deprecated `pre-commit.hooks`).
- `services.postgres` etc. wrap devenv's built-ins and additionally set the build environment (`libpq`, `LD_LIBRARY_PATH`, `MYSQLCLIENT_*`) needed by Python clients.

## Layout

```
flake.nix                    # templates.<name> outputs + lib.modules paths
lib/modules/
  direnv.nix
  delta.nix
  treefmt.nix
  git-hooks.nix
  lsp.nix
  strict-types.nix
  services/
    postgres.nix
    mysql.nix
    redis.nix
    sqlite.nix
templates/
  python/
  python+django/
  python+fastapi/
  python+flask/
```
