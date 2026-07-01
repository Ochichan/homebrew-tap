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
  version "1.5.8"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.8/ytm-tui-macos-arm64.tar.gz"
      sha256 "30ef5380a8dc1728045b59e81450535f044ac23421b424fe0c6486740b95983c"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.8/ytm-tui-macos-x64.tar.gz"
      sha256 "50a240592e40333bb82e833d7c48ce7f58e5289ec958791c773f742715cb821e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.8/ytm-tui-linux-arm64.tar.gz"
      sha256 "ec493875f6e85b3aea0bd008d233337ab62e57b5cec9a775fd82e7357b7e62b0"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.5.8/ytm-tui-linux-x64.tar.gz"
      sha256 "bac24bcdd4d7b0bac5c54ffe50e5416cbb249cfd6a81f5cf6de16a063c7b172e"
    end
  end

  def install
    bin.install "ytt"
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
