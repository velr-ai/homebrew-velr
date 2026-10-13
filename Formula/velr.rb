class Velr < Formula
  desc "Command-line shell and offline CSV importer for Velr"
  homepage "https://velr.ai"
  version "0.2.50"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.50/velr-v0.2.50-macos-aarch64.tar.gz"
      sha256 "1372b1c45f42f3c70d432e997fc535aa9eff91ff2d5a186aa121001b1b8babef"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.50/velr-v0.2.50-macos-x86_64.tar.gz"
      sha256 "2b0f8859ebc607bba9c30ea873399eeb5d6c6b5d2bd1627952e1fe8071d86c6a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.50/velr-v0.2.50-linux-aarch64.tar.gz"
      sha256 "f4bfe51aebab53f9f167e64cbb06edce26cc260ac3682ea4b90b27be2589b553"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.50/velr-v0.2.50-linux-x86_64.tar.gz"
      sha256 "305365160d10da475d4ff8c8d0debfc20977a5d5d9ba5435f94c7d81e8f9ed58"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.50-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr") && File.exist?("#{archive_dir}/velr-admin")

    bin.install "#{archive_dir}/velr"
    bin.install "#{archive_dir}/velr-admin"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.50", shell_output("#{bin}/velr --version")
    assert_match "0.2.50", shell_output("#{bin}/velr-admin --version")
    assert_match "database import full", shell_output("#{bin}/velr-admin --help")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
