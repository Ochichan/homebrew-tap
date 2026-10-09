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
  version "1.7.8"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.8/yututui-macos-arm64.tar.gz"
      sha256 "b1020860fd2acc78283a488e4aa97dc0f9580e70e2c5782cc62f71fd547a7227"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.8/yututui-macos-x64.tar.gz"
      sha256 "98fb05ad65f5f637808b60cfeb644de6901c2e6e9de6896105c9ead91444f15e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.8/yututui-linux-arm64.tar.gz"
      sha256 "5c431358e773fc5ab6f75ea03a0fd991632f3a697af024cb9470735c69683b51"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.8/yututui-linux-x64.tar.gz"
      sha256 "9fc0a11738d61098ab06f956421b23f954cae105a883c5fb97b2ae8566ec404a"
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
