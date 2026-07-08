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
  version "1.6.24"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "mpv"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.24/yututui-macos-arm64.tar.gz"
      sha256 "57e685fe33317c51347e937a9aecbd8183f7b7fe8c2ea484301a34bad7eb6014"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.24/yututui-macos-x64.tar.gz"
      sha256 "755731da56545d65076daedc95cb651fa143140fef433ca8428f50688fbcf308"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.24/yututui-linux-arm64.tar.gz"
      sha256 "5e6a91070294153d8c6b154b85f510b088c9233d0ef22049b2ce90c4b8c2bbe2"
    end
    on_intel do
      url "https://github.com/Ochichan/Yututui/releases/download/v1.6.24/yututui-linux-x64.tar.gz"
      sha256 "5105bb97490ad269e3a3af34c0b8311218e7cfe8108d921c05cbb00e86bf55af"
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
