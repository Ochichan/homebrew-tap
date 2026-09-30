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
  version "1.7.7"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.7/yututui-macos-arm64.tar.gz"
      sha256 "a369b12b3d1dd316177f7e49c8785263410e0a04f932d9e9e32fc7ed1b7476d6"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.7/yututui-macos-x64.tar.gz"
      sha256 "3c0f1325ab8f27bc7570955c81ce9ec78fa2ff364b453fe860b672236d80095d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.7/yututui-linux-arm64.tar.gz"
      sha256 "bb4a6754abbdf1b5c5df5f088f8a38aefee9fff7d644e33873709fa81f67ff6c"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.7.7/yututui-linux-x64.tar.gz"
      sha256 "fd2c1976bb1cee07f9dba8b3e6fb21e2954acd3fc2a3152567900bfc56c169d7"
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
