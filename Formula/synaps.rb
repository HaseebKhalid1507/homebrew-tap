class Synaps < Formula
  desc "Terminal-native AI agent runtime built in Rust"
  homepage "https://github.com/HaseebKhalid1507/SynapsCLI"
  url "https://github.com/HaseebKhalid1507/SynapsCLI/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "44c566b680a6a5def57b8fead30d5a39e3fe0c97d0d3bd59e95a03e5a08d85fe"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "synaps", shell_output("#{bin}/synaps --version")
  end
end
