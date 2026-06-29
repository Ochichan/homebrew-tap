class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  url "https://github.com/Ochichan/ytm-tui/archive/refs/tags/v1.5.3.tar.gz"
  sha256 "2c5f8537e8e35a0355ef160c40ed67030bfffa3828211eb131f266bb982a3450"
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
