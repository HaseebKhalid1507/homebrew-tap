class Synaps < Formula
  desc "Terminal-native AI agent runtime built in Rust"
  homepage "https://github.com/HaseebKhalid1507/SynapsCLI"
  url "https://github.com/HaseebKhalid1507/SynapsCLI/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "8ed10c95be85e4d6fda6d371db9bef03d0cb179541c51892688036260d61dc47"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "synaps", shell_output("#{bin}/synaps --version")
  end
end
