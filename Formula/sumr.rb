class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://github.com/SUMRco/Cli"
  license "UNLICENSED"
  version "0.0.7"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/SUMRco/Cli/releases/download/public-v#{version}/sumr-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/SUMRco/Cli/releases/download/public-v#{version}/sumr-darwin-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/Cli/releases/download/public-v#{version}/sumr-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/SUMRco/Cli/releases/download/public-v#{version}/sumr-linux-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    os   = OS.mac? ? "darwin" : "linux"
    bin.install "sumr-#{os}-#{arch}" => "sumr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sumr --version")
  end
end
