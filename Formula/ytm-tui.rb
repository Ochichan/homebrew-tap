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
  version "1.5.6"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.6/ytm-tui-macos-arm64.tar.gz"
      sha256 "3d6e42f1e12635f9d2efa0e2dda3842664bcc387c67a0df72f26a633266ae3dd"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.6/ytm-tui-macos-x64.tar.gz"
      sha256 "dced0b152f252f6676b6dd06302b0e4426cd12a60534f6418d918d1fdb1c3c3a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.6/ytm-tui-linux-arm64.tar.gz"
      sha256 "486642c2665e1d86931748f2236d828a8646dc7d106439002f0cd3f3e1a30e20"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.6/ytm-tui-linux-x64.tar.gz"
      sha256 "76d604bdc738792108b90944645ff8046ef66b8c3c9aafeb3e6dd3ca0e03df76"
    end
  end

  def install
    bin.install "ytt"
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
