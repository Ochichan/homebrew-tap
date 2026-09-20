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
  version "1.7.6"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.6/yututui-macos-arm64.tar.gz"
      sha256 "34b334fed00715af130a290a1c9a7fcdf045a65c488809c706be73722dc80ac7"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.6/yututui-macos-x64.tar.gz"
      sha256 "e8dad6a15f262b601cac82eb11b73092d41989b342925812da52dc3578c1507b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.6/yututui-linux-arm64.tar.gz"
      sha256 "abebd905d2e0115b090e319573cbc4b19368031c160d538263bbe79b0faaacab"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.6/yututui-linux-x64.tar.gz"
      sha256 "fb5da110a1efbd93abfec599b694dcf4bf98e3a5fc1e72fb20a93f22f5604325"
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
