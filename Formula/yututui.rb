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
  version "1.6.33"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.33/yututui-macos-arm64.tar.gz"
      sha256 "08c1671e3330b7c64f4e8107110aa8709709820bc9893cd6183c245a064ea722"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.33/yututui-macos-x64.tar.gz"
      sha256 "783530913a54a0e44f1b2bcf392f6ad3c2977eeae85e9004b02f3a5d084a5e76"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.33/yututui-linux-arm64.tar.gz"
      sha256 "f107dcad58eeca93ecf272cd921638b16b4cb389e96aaf4eb974248c58becb0b"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.33/yututui-linux-x64.tar.gz"
      sha256 "d4086841c96dc74a09a08334d69a160d34970ec9ad3852dd40256b618287ec4c"
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
