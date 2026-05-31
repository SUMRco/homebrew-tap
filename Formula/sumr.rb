class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.1.1"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/cli/releases/download/public-v0.1.1/sumr-darwin-arm64.tar.gz"
      sha256 "742109631bd38eb5beef9802cbab51e733126f350a22b7d3ab1d7da5645a8f10"
    else
      url "https://github.com/SUMRco/cli/releases/download/public-v0.1.1/sumr-darwin-x64.tar.gz"
      sha256 "33dfc8c4d623f02c68da0d028a3019f0323530f4ffc6a258571fde37c51bf767"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/cli/releases/download/public-v0.1.1/sumr-linux-arm64.tar.gz"
      sha256 "f743ad0121429e277060e12914011cd9a19675c1bd66ff9c4fb8a868c9bbb46f"
    else
      url "https://github.com/SUMRco/cli/releases/download/public-v0.1.1/sumr-linux-x64.tar.gz"
      sha256 "078741d891fd9f30145497bbaafcab5abd108f302f4091ae1e025f28063e4416"
    end
  end

  def install
    bin.install Dir["sumr-*"][0] => "sumr"
  end

  test do
    system "#{bin}/sumr", "--version"
  end
end
