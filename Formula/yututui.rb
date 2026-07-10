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
  version "1.6.26"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.26/yututui-macos-arm64.tar.gz"
      sha256 "0653f9b688964a93cf528e04bfa2df4466fc5bbb1f3c589d783c0e6c10936bab"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.26/yututui-macos-x64.tar.gz"
      sha256 "4a440988a07b610f727fe216acfdfa473ef33674c06c05810d69b793a5a5b79a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.26/yututui-linux-arm64.tar.gz"
      sha256 "83f716738e99bea0a1c21121e27a1c9cc86eb5946b475b592f20b055a4f84694"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.26/yututui-linux-x64.tar.gz"
      sha256 "d04cd6d2a1a5b2a57fd6d4ddd03160e35b930e79f0bd2a5f3c83a5aa39d17762"
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
