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

Each agent needs its own API key at runtime (e.g. `MISTRAL_API_KEY` for Mistral
Vibe). Only the agents you select are installed and allowed through the
firewall; everything else stays blocked.

### Other questions

| Question | Description |
| --- | --- |
| `node_version` | Node.js version for the base image (default `22`). |
| `enable_docker_in_docker` | Enable Docker-in-Docker (`docker build`/`compose` inside the container). |
| `enable_python_uv` | Install Python 3, `python3-venv`, and the `uv` package manager. |
| `enable_plone` | Install `plonecli` + Python/uv and allow `dist.plone.org` and PyPI. |
| `enable_pnpm` | Enable corepack and prepare `pnpm`. |
| `enable_terminal_recording` | Install terminal recording tools (asciinema, ffmpeg, vhs, agg, ttyd). |
| `extra_mounts` | Extra devcontainer mount entries, preserved across `copier update`. |
