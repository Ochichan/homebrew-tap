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
  version "1.7.0"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.0/yututui-macos-arm64.tar.gz"
      sha256 "27dfac661265918e80dbf75db9af0d00e04751806f1131f32e1e850798172b33"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.0/yututui-macos-x64.tar.gz"
      sha256 "e17e4734f1de01a825f8297a4c4f0b72a777d28df2c8e3bb9e585b26610fb88f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.0/yututui-linux-arm64.tar.gz"
      sha256 "1cf6a32c0bda973bc8aad9f5c2fec68a9168d92fdf39e915608715d2371514cd"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.0/yututui-linux-x64.tar.gz"
      sha256 "18d4def7cfc84341891ab08d13db68ed8da77308254bca59b24382d27ed21407"
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
