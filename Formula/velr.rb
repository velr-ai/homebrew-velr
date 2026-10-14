class Velr < Formula
  desc "Command-line shell and offline CSV importer for Velr"
  homepage "https://velr.ai"
  version "0.2.51"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.51/velr-v0.2.51-macos-aarch64.tar.gz"
      sha256 "a6326566d4d175918ac1b25e5a3870149eb95056442271960db7e6c229f833e5"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.51/velr-v0.2.51-macos-x86_64.tar.gz"
      sha256 "160e37a308bb0eff98b888b15f5ac9fbd2898be89941d03ed4eb211af9683fc7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.51/velr-v0.2.51-linux-aarch64.tar.gz"
      sha256 "9017bde25fcd7cfbab222ef0780213e5dbacc280f1cdc1e0651d9017d0c71bde"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.51/velr-v0.2.51-linux-x86_64.tar.gz"
      sha256 "ec6cc25c0850f285e989fed5d80ebea061a587485d94e46dc8fca6b19c164369"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.51-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr") && File.exist?("#{archive_dir}/velr-admin")

    bin.install "#{archive_dir}/velr"
    bin.install "#{archive_dir}/velr-admin"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.51", shell_output("#{bin}/velr --version")
    assert_match "0.2.51", shell_output("#{bin}/velr-admin --version")
    assert_match "database import full", shell_output("#{bin}/velr-admin --help")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
