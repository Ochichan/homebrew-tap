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
  version "1.6.27"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.27/yututui-macos-arm64.tar.gz"
      sha256 "5c2e8004966f91b3910ff1332bf5ff7feebdffe77870bf3223d4dd2a91dc74ea"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.27/yututui-macos-x64.tar.gz"
      sha256 "2e0829fdf18352d69194e48080e6779a0b5dbcb418c4a00df1bba7c41b228710"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.27/yututui-linux-arm64.tar.gz"
      sha256 "a099e25877b11344b4043ccc571ff705ae6b2a3184d9b18c4bc951256d5ae489"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.27/yututui-linux-x64.tar.gz"
      sha256 "b93f84e0dbc0443cb2a6cd6ceb846b6b29bd4676410a1cea8f445a82c633f37c"
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
