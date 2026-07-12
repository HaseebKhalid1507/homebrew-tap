class Synaps < Formula
  desc "Terminal-native AI agent runtime built in Rust"
  homepage "https://github.com/HaseebKhalid1507/SynapsCLI"
  url "https://github.com/HaseebKhalid1507/SynapsCLI/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "e1f408e7cb3a27065fe548f0d445bde2461ee403532ea6bc28e2087fb6beb049"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "synaps", shell_output("#{bin}/synaps --version")
  end
end
