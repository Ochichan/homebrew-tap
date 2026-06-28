class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  url "https://github.com/Ochichan/ytm-tui/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "cf61081b7e8917fdbc880f898bfcfd4e5ecf9fa5f1a19f25b4098893e134e3c9"
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
