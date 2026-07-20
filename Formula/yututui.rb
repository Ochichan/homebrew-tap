# Source of truth for the Homebrew formula in Ochichan/homebrew-tap.
# The `build` workflow renders this on every v* tag (filling the version and the four
# SHA-256 placeholders from the release checksums.txt) and pushes the result to
# Formula/yututui.rb in the tap. Do not edit the tap copy by hand — edit this template.
#
# A prebuilt-binary formula: it installs the binaries straight from the GitHub release
# (no Rust toolchain, no compile) and pulls in the three runtime tools as dependencies, so
# `brew install Ochichan/tap/yututui` is genuinely one command. macOS also gets `yututray`,
# the menu-bar companion (`yututray --background`, or `yututray --install-startup`
# for login). The
# tarball's YuTuTui!.app / YuTuTray!.app bundles are Finder conveniences; the formula
# installs only the CLIs and ignores the .apps.
class Yututui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/Yututui"
  version "1.6.35"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.35/yututui-macos-arm64.tar.gz"
      sha256 "bd4b7c8bc707529ef8902345c13537609f90bd47a8ea70cf1c4f2a5230e02fd2"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.35/yututui-macos-x64.tar.gz"
      sha256 "5509c15262fc2c4cc02dda559fcd36fef56705ca9ac328154cd1a003a3e66f0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.35/yututui-linux-arm64.tar.gz"
      sha256 "81e4feb0baeacc24da1ea6f2bf48d9cdaced8c4ae39e3a83803eddc381b4f524"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.35/yututui-linux-x64.tar.gz"
      sha256 "969759e00f9b0ab29c8c3593fcec6b508660e6ac1748a36977a1c5c6e828f754"
    end
  end

  def install
    bin.install "ytt"
    # The menu-bar companion ships in the macOS tarballs only; Linux is covered by
    # the MPRIS session built into `ytt` itself.
    bin.install "yututray" if OS.mac?
  end

  def caveats
    on_macos do
      <<~EOS
        The menu-bar companion is installed as `yututray`.
        Start it now with `yututray --background`, or keep it at login with:
          yututray --install-startup
      EOS
    end
  end

  test do
    assert_path_exists bin/"ytt"
    assert_path_exists bin/"yututray" if OS.mac?
  end
end
