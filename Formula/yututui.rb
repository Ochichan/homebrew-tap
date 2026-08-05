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
  version "1.7.2"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.2/yututui-macos-arm64.tar.gz"
      sha256 "8d233a7f30d17480c11ff8264aad36a409a738242995f24c064fca3408d4160c"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.2/yututui-macos-x64.tar.gz"
      sha256 "368e53bb3b36ff70b3c465354ffdb81befca052b2d5cdd0ce33d483a1babd5a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.2/yututui-linux-arm64.tar.gz"
      sha256 "3929fb6bb3424b57b4f30f4b525dbd93344b323d0e08945296c915240ee951eb"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.2/yututui-linux-x64.tar.gz"
      sha256 "16268bf7c777c068f703c94b73cec5a0ca62766dde3fe505cb08bef35b82dd9f"
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
