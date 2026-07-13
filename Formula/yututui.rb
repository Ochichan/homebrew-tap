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
  version "1.6.30"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.30/yututui-macos-arm64.tar.gz"
      sha256 "b4129119558337120f81df1148c5f2c74bc4d9ef302ef01be45512fb0e134194"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.30/yututui-macos-x64.tar.gz"
      sha256 "a8e2d3aaca2c82ab82ae770f411d4c8caaf1daed2ee99b4b1490f942c9b14971"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.30/yututui-linux-arm64.tar.gz"
      sha256 "0432ab3e7ec53bdf0b4a765b4fc1d9da26f2506f90a021619677fa3a5157bf47"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.30/yututui-linux-x64.tar.gz"
      sha256 "ef5584fbc386649462f755872331ac281ad6796e8afde2ef68306146994cd592"
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
