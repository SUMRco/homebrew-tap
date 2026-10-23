class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.8"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.8/sumr-darwin-arm64.tar.gz"
      sha256 "6827a0dc15b0c77ea8149197c7f33e2485f7ed676b0be965a41365b8e544bd15"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.8/sumr-darwin-x64.tar.gz"
      sha256 "acc87a9b1e79648afac842897eed1b7f30cf20bef94362beeb5ca751f456b2a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.8/sumr-linux-arm64.tar.gz"
      sha256 "d8e1eed3300cab55685d91431f09471336915a31b538d91f84f29936d1e42895"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.8/sumr-linux-x64.tar.gz"
      sha256 "2c72ea157cbe44409c839547898f64552891d34367ce0a66372ddebabe24233b"
    end
  end

  def install
    bin.install Dir["sumr-*"][0] => "sumr"

    (bin/"_sumr_cli").write <<~SH
      #!/bin/bash
      exec "#{bin}/sumr" ""
    SH

    (bin/"_sumr").write <<~SH
      #!/bin/bash
      "#{bin}/_sumr_cli" ""
      _sumr_rc=0
      return $_sumr_rc 2>/dev/null || exit $_sumr_rc
    SH

    chmod 0755, bin/"_sumr_cli"
    chmod 0755, bin/"_sumr"
  end

  test do
    system "#{bin}/sumr", "--version"
    system "#{bin}/_sumr", "--version"
  end
end
