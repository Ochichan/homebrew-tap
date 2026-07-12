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
  version "1.6.3"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.3/yututui-macos-arm64.tar.gz"
      sha256 "cb274453a9e02a53468238e8f7c1d6cb91faf37353bc2b470e143e4bee2016fb"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.3/yututui-macos-x64.tar.gz"
      sha256 "623fa9f76dd79a206a79bc7b01366d0a74f79b6e508f77c710b170aab7b1eec5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.3/yututui-linux-arm64.tar.gz"
      sha256 "4124435454048ed96bf714b7e16c77cebb4481daecb7a21bd0b651b9f6da27cb"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.3/yututui-linux-x64.tar.gz"
      sha256 "31d920c4339159abf91bc3f1423fbd88f4b5cf296a5d43445f455ae4ee4a2979"
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
