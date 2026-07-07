class Velr < Formula
  desc "Command-line shell for Velr"
  homepage "https://velr.ai"
  version "0.2.36"
  license all_of: ["MIT", :cannot_represent]

  on_macos do
    url "https://github.com/velr-ai/velr/releases/download/v0.2.36/velr-v0.2.36-macos-universal.tar.gz"
    sha256 "0742c57fcf9efc66f281492dea390c36f968175cacd95fb8a54e6164cbbf0e30"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/velr-ai/velr/releases/download/v0.2.36/velr-v0.2.36-linux-aarch64.tar.gz"
      sha256 "d82a15f41a6fceb0237b04c7018816f1ca451348032aecab6a5ebb26a94d2e0e"
    else
      url "https://github.com/velr-ai/velr/releases/download/v0.2.36/velr-v0.2.36-linux-x86_64.tar.gz"
      sha256 "e794168044935c285373559d442d802f677387eb489314f703a818915a42da18"
    end
  end

  def install
    archive_dir = if File.exist?("velr")
      "."
    else
      Dir["velr-v0.2.36-*"].first
    end
    raise "velr archive layout changed" unless archive_dir && File.exist?("#{archive_dir}/velr")

    bin.install "#{archive_dir}/velr"
    pkgshare.install "#{archive_dir}/README.md"
    pkgshare.install "#{archive_dir}/LICENSE"
    pkgshare.install "#{archive_dir}/LICENSE.runtime"
  end

  test do
    assert_match "velr-cli 0.2.36", shell_output("#{bin}/velr --version")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
