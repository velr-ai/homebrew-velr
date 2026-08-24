class Velr < Formula
  desc "Command-line shell for Velr"
  homepage "https://velr.ai"
  version "0.2.44"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    url "https://github.com/velr-ai/velr/releases/download/v0.2.44/velr-v0.2.44-macos-universal.tar.gz"
    sha256 "9d103664131e636e058481afebe2aeb9aee110cf63f0460428d8188ca55a806d"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.44/velr-v0.2.44-linux-aarch64.tar.gz"
      sha256 "2a76fac953d68e964962fee0a8431cc2d4ed2249612978be47997e8aa9487967"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.44/velr-v0.2.44-linux-x86_64.tar.gz"
      sha256 "bdd5ff14c2749c4533216d0fcfd93ce12f2eb4bf8c745e67c0d34e13479103cd"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.44-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr")

    bin.install "#{archive_dir}/velr"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.44", shell_output("#{bin}/velr --version")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
