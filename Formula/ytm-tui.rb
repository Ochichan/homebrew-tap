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
  version "1.6.2"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.2/ytm-tui-macos-arm64.tar.gz"
      sha256 "957fa7b19f8304f7ce43219e590984676dfab943979167b212cff069a4d4af55"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.2/ytm-tui-macos-x64.tar.gz"
      sha256 "19f2606be26c0ca965c89f2713084302433f896c4bfc79e63d87ee96c28a5e90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.2/ytm-tui-linux-arm64.tar.gz"
      sha256 "6e9106a86caf4d7cf40e58e883cb579cd20d00b954f320c3316cb5b09e273d2e"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.2/ytm-tui-linux-x64.tar.gz"
      sha256 "fcb91744f6d8c1798e26ce3e41b3f6fcd870ddf022f17ce54a093d8d51667689"
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
