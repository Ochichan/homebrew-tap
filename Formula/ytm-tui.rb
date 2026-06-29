class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  url "https://github.com/Ochichan/ytm-tui/archive/refs/tags/v1.5.2.tar.gz"
  sha256 "c4240f0f9469a18ccbeda8350df6fa1b8748b183ce1c4b315ab6fb7b10dbc127"
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
