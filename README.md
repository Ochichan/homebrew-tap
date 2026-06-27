# homebrew-tap

Homebrew tap for [ytm-tui](https://github.com/Ochichan/ytm-tui) — a fast, low-RAM YouTube Music
player for your terminal.

```sh
brew install Ochichan/tap/ytm-tui
```

This builds from source (needs the `rust` build toolchain, installed automatically) and pulls in
`mpv` and `yt-dlp` for playback. Then run:

```sh
ytm
```

Cookies are optional. Public search and playback work without a cookie file. For signed-in
YouTube Music access or gated tracks, export a Netscape-format `cookies.txt` to:

```sh
~/Music/ytm-tui/cookies.txt
```

Keep that file private; it can act like a logged-in browser session.
