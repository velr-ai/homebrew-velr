class Velr < Formula
  desc "Command-line shell and offline CSV importer for Velr"
  homepage "https://velr.ai"
  version "0.2.49"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.49/velr-v0.2.49-macos-aarch64.tar.gz"
      sha256 "8883b713237743fb77788f12133b2601b74596e1b61bf8a120e577a8ef8f74f4"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.49/velr-v0.2.49-macos-x86_64.tar.gz"
      sha256 "5c8fd59478bb99ae0a7a566ff063a02c3ceaa93a86cd662173bf7f160db436fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.49/velr-v0.2.49-linux-aarch64.tar.gz"
      sha256 "3169ca7a8861c520bdb3132d043232cfdb3bd1406bc454a86875bca94614fa28"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.49/velr-v0.2.49-linux-x86_64.tar.gz"
      sha256 "8b68876d824838bb6875e4f703d72af1ad5dc823ba1f256a393e79234ab0669a"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.49-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr") && File.exist?("#{archive_dir}/velr-admin")

    bin.install "#{archive_dir}/velr"
    bin.install "#{archive_dir}/velr-admin"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.49", shell_output("#{bin}/velr --version")
    assert_match "0.2.49", shell_output("#{bin}/velr-admin --version")
    assert_match "database import full", shell_output("#{bin}/velr-admin --help")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
