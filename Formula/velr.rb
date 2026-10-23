class Velr < Formula
  desc "Command-line shell and offline CSV importer for Velr"
  homepage "https://velr.ai"
  version "0.2.55"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.55/velr-v0.2.55-macos-aarch64.tar.gz"
      sha256 "91237afa57b30fbc36c63be6df92442f5f597eff4edfab1581836e5807786390"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.55/velr-v0.2.55-macos-x86_64.tar.gz"
      sha256 "105f5b53c43e7a21cc197fcd15d794913007fb73ee6a07f7b1627c79847f9e4e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.55/velr-v0.2.55-linux-aarch64.tar.gz"
      sha256 "e566431f1a34ae0bf36a12938bdd5d587d08f3c5035708a94c423a0ee7002f60"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.55/velr-v0.2.55-linux-x86_64.tar.gz"
      sha256 "0f83830beb5e4e4df4cbd454b5901a98635b74be2da60cec317b16f8264a9e83"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.55-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr") && File.exist?("#{archive_dir}/velr-admin")

    bin.install "#{archive_dir}/velr"
    bin.install "#{archive_dir}/velr-admin"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.55", shell_output("#{bin}/velr --version")
    assert_match "0.2.55", shell_output("#{bin}/velr-admin --version")
    assert_match "database import full", shell_output("#{bin}/velr-admin --help")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
