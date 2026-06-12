class Synaps < Formula
  desc "Terminal-native AI agent runtime built in Rust"
  homepage "https://github.com/HaseebKhalid1507/SynapsCLI"
  url "https://github.com/HaseebKhalid1507/SynapsCLI/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "74ab8d738cc9eadb6de1ef361fc8e148d93b11528c76c904686b5055e9e8ef24"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "synaps", shell_output("#{bin}/synaps --version")
  end
end
