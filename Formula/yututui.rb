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
  version "1.7.3"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.3/yututui-macos-arm64.tar.gz"
      sha256 "f1d82824c86aa553bbe53ca55737b12ce057dd8405e20e0cf05667559d46a61a"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.3/yututui-macos-x64.tar.gz"
      sha256 "1e00b98cfcd3a57841057fff113b2c2323a56520c3f8e4530f9cb95c1b6df77d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.3/yututui-linux-arm64.tar.gz"
      sha256 "42dccbb9a0da378ff4b55a37e3a2b245b5e2bdb3b706a7a8c067f5be1aca208d"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.3/yututui-linux-x64.tar.gz"
      sha256 "79e5b6dfa6db06500f479112b82cd4b0bae555e5b26a9f014d0c27cf68b58dcd"
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
