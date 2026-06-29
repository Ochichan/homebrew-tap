class YtmTui < Formula
  desc "Fast, low-RAM YouTube Music player for your terminal"
  homepage "https://github.com/Ochichan/ytm-tui"
  url "https://github.com/Ochichan/ytm-tui/archive/refs/tags/v1.5.4.tar.gz"
  sha256 "3496cea9da6dede3fff11616c6f4b8e1d4791c54c509bbeea7c5c2f66fdbb246"
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
