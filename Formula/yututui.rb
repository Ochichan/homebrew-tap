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
  version "1.6.22"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.22/yututui-macos-arm64.tar.gz"
      sha256 "9249a26797d81bb9b455ebb98b6af1af82723d9cd642fb2baa0db0a7a9a5b743"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.22/yututui-macos-x64.tar.gz"
      sha256 "42faeb1d8189499ccfe3afb4e7be4b4a57ea0be3e316c3e7b5f5f2c88098eb77"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.22/yututui-linux-arm64.tar.gz"
      sha256 "163cea16ca1ccc5f9c449bb2424ea257f01af28987087052aead180ff50367ef"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.22/yututui-linux-x64.tar.gz"
      sha256 "f68fef9fed636eaa17c29110e310fd33365952e9a171cf3c28c3e8e2effdb593"
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
