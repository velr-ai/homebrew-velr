class Velr < Formula
  desc "Command-line shell for Velr"
  homepage "https://velr.ai"
  url "https://github.com/velr-ai/velr.git",
      tag:      "v0.2.36",
      revision: "ccb593d61b883c960a80232aaff93cb248d1a137"
  license all_of: ["MIT", :cannot_represent]

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "rust/velr-cli")
  end

  test do
    assert_match "velr-cli 0.2.36", shell_output("#{bin}/velr --version")
    assert_equal "n\n1\n", shell_output("#{bin}/velr -f tsv -e 'RETURN 1 AS n'")
  end
end
