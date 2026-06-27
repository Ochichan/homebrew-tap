class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  url "https://github.com/Ochichan/ytm-tui/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "b2221835cad9c1136d0ab49adb798048d80702996726bde85dd163e89d5a5be0"
  license "MIT"
  head "https://github.com/Ochichan/ytm-tui.git", branch: "main"

  depends_on "rust" => :build
  depends_on "mpv"
  depends_on "yt-dlp"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_path_exists bin/"ytt"
  end
end
