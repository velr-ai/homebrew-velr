class Velr < Formula
  desc "Command-line shell and offline CSV importer for Velr"
  homepage "https://velr.ai"
  version "0.2.59"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.59/velr-v0.2.59-macos-aarch64.tar.gz"
      sha256 "8a7d931c92e55c35187ec82496e19084eeb22de8c3be26f2f00e3332af897b33"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.59/velr-v0.2.59-macos-x86_64.tar.gz"
      sha256 "4e0623c364ec43b46c94f46b83a78cdceb3836a7ea3d5af545242c183720abd1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.59/velr-v0.2.59-linux-aarch64.tar.gz"
      sha256 "da60382c8b5135aede6f1852b6f11282dc62676586175961100ccd20966d27b4"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.59/velr-v0.2.59-linux-x86_64.tar.gz"
      sha256 "272cfc0e1b03c76fefc7c76361dbfb2b7d78f026114af38f0c1103399c1c6726"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.59-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr") && File.exist?("#{archive_dir}/velr-admin")

    bin.install "#{archive_dir}/velr"
    bin.install "#{archive_dir}/velr-admin"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.59", shell_output("#{bin}/velr --version")
    assert_match "0.2.59", shell_output("#{bin}/velr-admin --version")
    assert_match "database import full", shell_output("#{bin}/velr-admin --help")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
