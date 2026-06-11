# homebrew-tap

Personal Homebrew tap (`brew tap generald/tap`) distributing GeneralD's own
macOS tools that are not in official taps.

## Stack

- Ruby Homebrew DSL only — no build system, no tests, no CI.
- Status: active; formulae are bumped when upstream releases ship.

## Layout

- `Formula/` — CLI formulae:
  - `lyra.rb` — desktop lyrics overlay / video wallpaper (prebuilt arm64 binary, Swift source fallback; depends on yt-dlp, ffmpeg)
  - `magia.rb` — NFT generator (builds via `make install`)
  - `sutra.rb` — template engine (builds via `make install`)
- `Casks/video-screen-saver.rb` — macOS screensaver cask installing `VideoScreenSaver.saver`.

## Conventions

- Formulae point at GitHub release tarballs of sibling `GeneralD/*` repos with pinned `sha256`.
- CLI formulae generate zsh completions via `generate_completions_from_executable` (opt-out with `--without-completions`).
- To verify a formula locally: `brew install --build-from-source ./Formula/<name>.rb` or `brew audit --strict ./Formula/<name>.rb`.

License: Apache-2.0.
