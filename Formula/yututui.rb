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
  version "1.7.1"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.1/yututui-macos-arm64.tar.gz"
      sha256 "7a45bddc2774faf17e90b8223539a9bbe1320d2543604a7b3c2ec8c3d4c8f0d8"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.1/yututui-macos-x64.tar.gz"
      sha256 "299303055dce94e191299ba35ed4b49aeb4434abf772cc13f57aaa6461503de5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.1/yututui-linux-arm64.tar.gz"
      sha256 "73a0d5315300827e42fb956c78f9769fee8d891cac25b1c2038bf45c3904a750"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.1/yututui-linux-x64.tar.gz"
      sha256 "8e969bede38fcdafea5eb2c97597b4e7c4a861ca1fe1b1a8762d7c1443374d37"
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
