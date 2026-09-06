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
  version "1.7.5"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.5/yututui-macos-arm64.tar.gz"
      sha256 "be628e62191dd12a71eff278aca0b6aed10d97cd859b9a5ce499422fe7f64b65"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.5/yututui-macos-x64.tar.gz"
      sha256 "183a13468ed47e5409446acfe33492062437b103e9227bcc1e4cece874540eed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.5/yututui-linux-arm64.tar.gz"
      sha256 "1b4369921fc648e6b3b8f511ffdb9fec08061805e9b47a520caad906f91da186"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.5/yututui-linux-x64.tar.gz"
      sha256 "aeea1d5b78c63203dfc99b9bbeacb0341968c4a71dfc60a6bba161c45f64e357"
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
