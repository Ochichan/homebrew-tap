# Source of truth for the Homebrew formula in Ochichan/homebrew-tap.
# The `build` workflow renders this on every v* tag (filling the version and the four
# SHA-256 placeholders from the release checksums.txt) and pushes the result to
# Formula/ytm-tui.rb in the tap. Do not edit the tap copy by hand — edit this template.
#
# A prebuilt-binary formula: it installs the binaries straight from the GitHub release
# (no Rust toolchain, no compile) and pulls in the three runtime tools as dependencies, so
# `brew install Ochichan/tap/ytm-tui` is genuinely one command. macOS also gets `ytt-desktop`,
# the menu-bar companion (`ytt-desktop --background`, or `ytt-desktop --install-startup`
# for login). The
# tarball's YtmTui.app / YPlayer.app bundles are Finder conveniences; the formula
# installs only the CLIs and ignores the .apps.
class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  version "1.6.21"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.21/ytm-tui-macos-arm64.tar.gz"
      sha256 "1075a5e61e6bba621d32f7286de6e563b1ea30675d3b0264cde966d19b8e7ff2"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.21/ytm-tui-macos-x64.tar.gz"
      sha256 "e7cd59d577e52f7e7f9b03fdccbb37d15924724851d221ed90199274cd10feef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.21/ytm-tui-linux-arm64.tar.gz"
      sha256 "2c5d11d9c46fcee5b8fe7a87d591034581939e56fc79e6617b0f64531de9700b"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.21/ytm-tui-linux-x64.tar.gz"
      sha256 "7e07bcca5bc7261ded840edd492635ee3d82b3509c88b881da403f4532d15924"
    end
  end

  def install
    bin.install "ytt"
    # The menu-bar companion ships in the macOS tarballs only; Linux is covered by
    # the MPRIS session built into `ytt` itself.
    bin.install "ytt-desktop" if OS.mac?
  end

  def caveats
    on_macos do
      <<~EOS
        The menu-bar companion is installed as `ytt-desktop`.
        Start it now with `ytt-desktop --background`, or keep it at login with:
          ytt-desktop --install-startup
      EOS
    end
  end

  test do
    assert_path_exists bin/"ytt"
    assert_path_exists bin/"ytt-desktop" if OS.mac?
  end
end
