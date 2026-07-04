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
      sha256 "ac8af4a2aff974de7d3f32735cde6a1ea022d2c3382ee4d68b30da84b5df6c24"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-macos-x64.tar.gz"
      sha256 "f41f6155bff57aff06d50d1fd6019be2e286da6d1d09c045e81083b0e93d05d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-linux-arm64.tar.gz"
      sha256 "342e38ccff7858ef05c1b165c7094b4b1c96f3b8dd4a41c5c699d2fc82444307"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-linux-x64.tar.gz"
      sha256 "d7d22f67c8b044168aaadeae25bc4388d18af6d7e6e24ee11226a3e0cdd1b7e8"
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
