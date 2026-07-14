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
  version "1.6.31"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.31/yututui-macos-arm64.tar.gz"
      sha256 "2052b03a08ebe4db2bfae606b181ddc7f246e7167a9d448557e23a10de3daee8"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.31/yututui-macos-x64.tar.gz"
      sha256 "6e1b43d8923e46116f83cfc1c90a5efcc3420d876f104e7356d676d10951ba40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.31/yututui-linux-arm64.tar.gz"
      sha256 "f0bdd14dc46c4ef2227fd0498056e21b993883bb63af39d9ad1e263da59ee62a"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.31/yututui-linux-x64.tar.gz"
      sha256 "9fdd161b9c292cea479c61c7e0239bd65d88d0c64ef8596d91bb600f5d3d38cf"
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
