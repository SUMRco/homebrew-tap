<h1 align="center">
  <p align="right">
    <img src="https://dev.sumr.co/sumr-docs.svg?v=1" alt="SUMR" width="200" />
  </p>
</h1>

# SUMR Homebrew Tap

Official Homebrew tap for installing and updating the SUMR CLI.

The `sumr` command gives teams one local entrypoint for SUMR developer
workflows, including Playbook, Mission, Kontract, and related project tools.

## Install

Install the latest SUMR CLI release directly:

```bash
brew install sumrco/tap/sumr
```

Or add the tap first, then install:

```bash
brew tap sumrco/tap
brew install sumr
```

Verify the install:

```bash
sumr --version
sumr --help
```

## Formulae

| Formula | Description | Install |
|---|---|---|
| `sumr` | Official SUMR CLI | `brew install sumrco/tap/sumr` |

The formula currently publishes prebuilt binaries for:

- macOS on Apple Silicon (`arm64`)
- macOS on Intel (`x64`)
- Linux on ARM (`arm64`)
- Linux on x64

## Update

Homebrew refreshes tapped formulae during `brew update`.

```bash
brew update
brew upgrade sumr
```

If the tap was updated but your local Homebrew metadata still looks stale:

```bash
brew update --force
```

## Uninstall

Remove the SUMR CLI:

```bash
brew uninstall sumr
```

Remove the tap if you no longer need it:

```bash
brew untap sumrco/tap
```

## Troubleshooting

### Formula not found

Make sure the tap is available locally:

```bash
brew tap sumrco/tap
brew install sumrco/tap/sumr
```

### Installation fails

Refresh Homebrew metadata and retry:

```bash
brew update
brew install sumrco/tap/sumr
```

If the problem continues, open an issue with:

- your operating system and CPU architecture
- `brew --version`
- the full Homebrew error output

## About this tap

This repository contains the Homebrew formula for the official SUMR CLI.
Release artifacts are published as GitHub release assets and referenced by
`Formula/sumr.rb`.

Useful links:

- [SUMR website](https://sumr.co)
- [Homebrew](https://brew.sh)
- [Homebrew taps documentation](https://docs.brew.sh/Taps)

