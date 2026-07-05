# Source of truth for the Homebrew formula in Ochichan/homebrew-tap.
# The `build` workflow renders this on every v* tag (filling the version and the four
# SHA-256 placeholders from the release checksums.txt) and pushes the result to
# Formula/ytm-tui.rb in the tap. Do not edit the tap copy by hand — edit this template.
#
# A prebuilt-binary formula: it installs the binaries straight from the GitHub release
# (no Rust toolchain, no compile) and pulls in the three runtime tools as dependencies, so
# `brew install Ochichan/tap/ytm-tui` is genuinely one command. macOS also gets `ytt-desktop`,
# the menu-bar companion (run it once, or `ytt-desktop --install-startup` for login). The
# tarball's YtmTui.app / YPlayer.app bundles are Finder conveniences; the formula
# installs only the CLIs and ignores the .apps.
class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  version "1.6.0"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-macos-arm64.tar.gz"
      sha256 "8995c6eac5fd995fa36d04ea9da8e0d01c7c5e8e664ae4f967e1e3fc05948e0e"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-macos-x64.tar.gz"
      sha256 "960c0de0ee914a58838c6bba3384af138c119ea91c0f80f8137711cf9448bf8b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-linux-arm64.tar.gz"
      sha256 "0ab93c3ecac20dc2d9be8e6b5339a8523b4f6cbb91d2ea78fd99d4d080f2ad18"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-linux-x64.tar.gz"
      sha256 "206f083deafff3723a5b9094f869595b0456c3ba2702ff1fada2fdc66d8dee17"
    end
  end

  def install
    bin.install "ytt"
    # The menu-bar companion ships in the macOS tarballs only; Linux is covered by
    # the MPRIS session built into `ytt` itself.
    bin.install "ytt-desktop" if OS.mac?
  end

  def caveats
    on_macos do
      <<~EOS
        The menu-bar companion is installed as `ytt-desktop`.
        Start it now with `ytt-desktop`, or keep it at login with:
          ytt-desktop --install-startup
      EOS
    end
  end

  test do
    assert_path_exists bin/"ytt"
    assert_path_exists bin/"ytt-desktop" if OS.mac?
  end
end
