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
  version "1.6.0-rc1"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0-rc1/ytm-tui-macos-arm64.tar.gz"
      sha256 "0ba9f964619986dfafa35b9368961c8957a8dd81f5c2132aa233d0cbe4c2cb0f"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0-rc1/ytm-tui-macos-x64.tar.gz"
      sha256 "c3341d8764e40b69cd35bf5ed9ac314c2cde55aaeb595545ad63d9b45284cdeb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0-rc1/ytm-tui-linux-arm64.tar.gz"
      sha256 "37f48cb8c9d10e0bdf7e4c53cedbd68ed4930ee2e2127f3f91941514ddae5082"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0-rc1/ytm-tui-linux-x64.tar.gz"
      sha256 "85abdb5525fa0bcf1330a17b6b77552eff384ca910eb78d0b456924da2781913"
    end
  end

  def install
    bin.install "ytt"
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
