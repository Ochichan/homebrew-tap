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
      sha256 "719b77d2fc3ea8ad9aba81dae26852a1a012778df14cb3f8df599dca18f1148a"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-macos-x64.tar.gz"
      sha256 "22ffc47e5127caa8bc9573e76a314d81eb879e5d61b44310a9cfdd74a797b2e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-linux-arm64.tar.gz"
      sha256 "06e297bc5461a5cef03e768cfbc6ccffe85909f01ba1c0a0369b3b6a6b068298"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.5/ytm-tui-linux-x64.tar.gz"
      sha256 "138ede688263c3454a19ad96aed7b1991d74fbd1897dfb66bd89e13b97df8edf"
    end
  end

  def install
    bin.install "ytt"
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
