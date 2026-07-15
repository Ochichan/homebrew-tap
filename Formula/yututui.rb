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
  version "1.6.32"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.32/yututui-macos-arm64.tar.gz"
      sha256 "54255ce16787093b983288f78eecbc33f38735a759427fea131a8bbbaec44117"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.32/yututui-macos-x64.tar.gz"
      sha256 "044003ef283e3edc2946333f4a10837f23e4c9d3ea65f50605ebbfee2749b7b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.32/yututui-linux-arm64.tar.gz"
      sha256 "624f222822fc1915fdf111f8a34d4cdf3b539019938a08eac6c4f13b7f2adeec"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.32/yututui-linux-x64.tar.gz"
      sha256 "6befc997829a8d965915e25fedf966d355124f8e4042801a6743e5af3cbe0156"
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
