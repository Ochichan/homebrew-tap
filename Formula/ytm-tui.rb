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
  version "1.5.5"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-macos-arm64.tar.gz"
      sha256 "a3c5c9ec564e38f288ff1003c5e3b01616d5d8f766bcc223322c67de6258d3c4"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-macos-x64.tar.gz"
      sha256 "2187e348b3d7ed031d83847f05ca01abfa5977f8729b57aadcc0a63e2f10ca29"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-linux-arm64.tar.gz"
      sha256 "3ae09844296a67bd4f6d01b36461ae8b4f1a184ee250481f6e1b164e0b5abd79"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-linux-x64.tar.gz"
      sha256 "a732bc13a66107093aebad63273bf56ce6682f0797752ba015ea342d1aab926f"
    end
  end

  def install
    bin.install "ytt"
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
