class Synaps < Formula
  desc "Terminal-native AI agent runtime built in Rust"
  homepage "https://github.com/HaseebKhalid1507/SynapsCLI"
  url "https://github.com/HaseebKhalid1507/SynapsCLI/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "63f93afd08473cc17489b0ab4bc7099dc0be3e89b33040c450a3ae09f0e75792"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "synaps", shell_output("#{bin}/synaps --version")
  end
end
