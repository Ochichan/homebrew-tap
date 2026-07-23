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
  version "1.6.36"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.36/yututui-macos-arm64.tar.gz"
      sha256 "25491f23e8ccbc4ff663f90f6450c736965746a1c9893dfd49146206a38a0df1"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.36/yututui-macos-x64.tar.gz"
      sha256 "e5a3b74f55406307db9969c40f3e7f6279042fdd083589c8193e50835c326a67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.36/yututui-linux-arm64.tar.gz"
      sha256 "221a62b413e0145690cb9693deb9e634987c7c52077a2e5040d27883afec202f"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.36/yututui-linux-x64.tar.gz"
      sha256 "0a564ae95e8adfecf6d996009bbd8c4deaf8458b07809447575e2dbdd4825fb4"
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
