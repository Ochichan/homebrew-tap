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
  version "1.6.0"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-macos-arm64.tar.gz"
      sha256 "eedd6c62fd4ccae77a99dad97a90a999daf1c24c28815fade3a11b6652c63980"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-macos-x64.tar.gz"
      sha256 "1d0cb6889ad90670122d60a847a31fff9603d4e17b3248ef1d104057b80200b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-linux-arm64.tar.gz"
      sha256 "9db7947dac9f9200169f75b6d80d2770dc7ab479f8d0f5ef5fcaa8f5f723009c"
    end
    on_intel do
      url "https://github.com/Ochichan/ytm-tui/releases/download/v1.6.0/ytm-tui-linux-x64.tar.gz"
      sha256 "b378ef5f64a5218dc50b3d7ff55ba3ca00cc03c7da8785541189db98e89c67fa"
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
