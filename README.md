# Copier template to add a claude code `.devcontainer` folder to your project

[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)


## Usage

### Install `copier`

If you don't have `copier` already installed, the easiest way is to install it as tool with [UV](https://docs.astral.sh/uv/guides/tools/):

```sh
uv tool install copier
```

This will install copier as a `uv` tool and you can run it directly.

### Use the template to add the devcontainer folder

In your project folder run:

```sh
copier copy gh:derico-de/copier-claude-code-devcontainer .
```

Copier will ask a few questions to tailor the devcontainer. The most important
one is which coding agents to install.

## Options

### Coding agents (`agents`)

A multi-select question that controls which AI coding agent CLIs are installed
in the container **and** which API domains are opened in the container firewall.
You must select at least one.

| Choice | Installed via | Firewall domains opened |
| --- | --- | --- |
| **Claude Code** | native installer (`claude.ai/install.sh`) | `api.anthropic.com`, `claude.ai`, `sentry.io`, `statsig.com` |
| **Mistral Vibe** | `uv tool install mistral-vibe` (managed Python 3.12) | `api.mistral.ai`, `codestral.mistral.ai`, PyPI |
| **OpenCode** | `npm install -g opencode-ai` | `opencode.ai` |
| **Pi** | native installer (`pi.dev/install.sh`) + `rpiv-web-tools` extension | `pi.dev`, `api.anthropic.com`, `api.openai.com`, `generativelanguage.googleapis.com` |

Each agent needs its own API key at runtime (e.g. `MISTRAL_API_KEY` for Mistral
Vibe). Pi is provider-agnostic, so the firewall opens the Anthropic, OpenAI, and
Google endpoints; configure whichever provider/key you use. Only the agents you
select are installed and allowed through the firewall; everything else stays
blocked.

#### Pi web tools + SearXNG

When **Pi** is selected, the
[`@juicesharp/rpiv-web-tools`](https://pi.dev/packages/@juicesharp/rpiv-web-tools)
extension is installed (`pi install npm:@juicesharp/rpiv-web-tools`), adding
`web_search` / `web_fetch` tools backed by [SearXNG](https://docs.searxng.org/).

The template assumes SearXNG runs **on the Docker host** and wires the container
to it:

- the container gets `--add-host=host.docker.internal:host-gateway`, and
- `SEARXNG_URL` is set from the `searxng_url` answer
  (default `http://host.docker.internal:8099`).

The host network is already allowed through the firewall, so no extra firewall
rule is needed for the default host-local instance. Make sure your SearXNG
instance listens on an interface reachable from the container (not only
`127.0.0.1`) and has JSON output enabled (`search.formats: [html, json]` in
`settings.yml`) — default installs ship with JSON disabled. If you point
`searxng_url` at an external host instead, add that domain to
`init-firewall.sh`.

### Other questions

| Question | Description |
| --- | --- |
| `node_version` | Node.js version for the base image (default `22`). |
| `enable_docker_in_docker` | Enable Docker-in-Docker (`docker build`/`compose` inside the container). |
| `enable_python_uv` | Install Python 3, `python3-venv`, and the `uv` package manager. |
| `enable_plone` | Install `plonecli` + Python/uv and allow `dist.plone.org` and PyPI. |
| `enable_pnpm` | Enable corepack and prepare `pnpm`. |
| `enable_terminal_recording` | Install terminal recording tools (asciinema, ffmpeg, vhs, agg, ttyd). |
| `enable_zellij` | Install the Zellij multiplexer with the `zjstatus` and `zj-status-bar` status-bar plugins (see below). |
| `extra_mounts` | Extra devcontainer mount entries, preserved across `copier update`. |

### Zellij status bar (`enable_zellij`)

Installs the [Zellij](https://zellij.dev/) terminal multiplexer plus two
status-bar plugins, [`zjstatus`](https://github.com/dj95/zjstatus) and
[`zj-status-bar`](https://github.com/cristiand391/zj-status-bar). The plugin
`.wasm` files are baked into the image at `~/.config/zellij/plugins/` and two
ready-made layouts are shipped in `~/.config/zellij/layouts/`:

- `zjstatus` (the default layout) — run `zellij`
- `zj-status-bar` — run `zellij --layout zj-status-bar`

On first launch each plugin prompts for permissions: focus the status pane and
press `y`.
