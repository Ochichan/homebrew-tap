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
  version "1.6.23"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.23/yututui-macos-arm64.tar.gz"
      sha256 "9881fac2ab55975bddc05098cd7fcaf347152da2a5fb457a843a408d0130830e"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.23/yututui-macos-x64.tar.gz"
      sha256 "366ac970f7ff407077df7ac12b3b3af378ff0cc1d3f8976c2045636f5d065850"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.23/yututui-linux-arm64.tar.gz"
      sha256 "06ea66454c6bc0ddd14d40da2820756bb687a8a822b9f5a9fc8acf54a7f9506d"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.23/yututui-linux-x64.tar.gz"
      sha256 "b37d5382e90298b9437757873a5df4e269a6f16397f8c7228d7fc9dcb60c3716"
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
