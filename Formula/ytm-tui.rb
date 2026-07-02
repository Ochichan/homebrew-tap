# Source of truth for the Homebrew formula in Ochichan/homebrew-tap.
# The `build` workflow renders this on every v* tag (filling the version and the four
# SHA-256 placeholders from the release checksums.txt) and pushes the result to
# Formula/ytm-tui.rb in the tap. Do not edit the tap copy by hand — edit this template.
#
# A prebuilt-binary formula: it installs the binaries straight from the GitHub release
# (no Rust toolchain, no compile) and pulls in the three runtime tools as dependencies, so
# `brew install Ochichan/tap/ytm-tui` is genuinely one command. macOS also gets `ytt-tray`,
# the menu-bar companion (run it once, or `ytt-tray --install-startup` for login). The
# tarball's YtmTui.app / YtmTuiTray.app bundles are Finder conveniences; the formula
# installs only the CLIs and ignores the .apps.
class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  version "1.5.9"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.9/ytm-tui-macos-arm64.tar.gz"
      sha256 "02e643d6d88ce0f8924538c7e36d87d08c47cf2483cac63564898e135c5b3160"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.9/ytm-tui-macos-x64.tar.gz"
      sha256 "b75c0ce970cdc1083f0d4adca81a93d0c98c316f42b78b729f5dec2630c7725c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.9/ytm-tui-linux-arm64.tar.gz"
      sha256 "b7603ac06e4cc4a98c0e4f2d9bed10e19129ed01a5d8c172f9d75564e04d00e0"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.9/ytm-tui-linux-x64.tar.gz"
      sha256 "aa38b5c196bed5f0de1bd2d20d7501f9e5f87152ccffb3a7c9c3130ee63c3656"
    end
  end

  def install
    bin.install "ytt"
    # The menu-bar companion ships in the macOS tarballs only; Linux is covered by
    # the MPRIS session built into `ytt` itself.
    bin.install "ytt-tray" if OS.mac?
  end

  def caveats
    on_macos do
      <<~EOS
        The menu-bar companion is installed as `ytt-tray`.
        Start it now with `ytt-tray`, or keep it at login with:
          ytt-tray --install-startup
      EOS
    end
  end

  test do
    assert_path_exists bin/"ytt"
    assert_path_exists bin/"ytt-tray" if OS.mac?
  end
end
