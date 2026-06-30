# Source of truth for the Homebrew formula in Ochichan/homebrew-tap.
# The `build` workflow renders this on every v* tag (filling the version and the four
# SHA-256 placeholders from the release checksums.txt) and pushes the result to
# Formula/ytm-tui.rb in the tap. Do not edit the tap copy by hand — edit this template.
#
# A prebuilt-binary formula: it installs the `ytt` binary straight from the GitHub release
# (no Rust toolchain, no compile) and pulls in the three runtime tools as dependencies, so
# `brew install Ochichan/tap/ytm-tui` is genuinely one command. (The macOS tarball also
# carries a YtmTui.app bundle; the formula installs only the CLI and ignores the .app.)
class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  version "1.5.7"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.7/ytm-tui-macos-arm64.tar.gz"
      sha256 "03e6348432d0ed17192e660c86c80c9ef6ec3bca792b149cfd5e9318b0b3630b"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.7/ytm-tui-macos-x64.tar.gz"
      sha256 "f4395a496e51ab65f75d0ffec2b285d99eefa01de5c938d905aea9fbfaf98b54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.7/ytm-tui-linux-arm64.tar.gz"
      sha256 "ef1180d41de2cb2fc35472b353d22279e55a7d18e749ed11dc8be9f80e4b554c"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.7/ytm-tui-linux-x64.tar.gz"
      sha256 "37a263eb004e4f964d28afaa4713a1566bba89c6e6d0c68ec8d2c952b6745864"
    end
  end

  def install
    bin.install "ytt"
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
