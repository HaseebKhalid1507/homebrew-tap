class Myx < Formula
  desc "A lean, beautiful terminal Spotify player"
  homepage "https://github.com/HaseebKhalid1507/Myx"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.3.0/myx-aarch64-apple-darwin.tar.gz"
      sha256 "4fa491133a95783fd759e25decfc522a2296adcc88e9e79a4511449668435460"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.3.0/myx-x86_64-apple-darwin.tar.gz"
      sha256 "488f9c6f49273c2727ef8584faeae30c22ca782e29aa5f629683f0c53c48dc57"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.3.0/myx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "cf20b70572c55bfe6906f112b006f21d27aaab487b105c2750fb7a8e291f0c0e"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "myx" if OS.mac? && Hardware::CPU.arm?
    bin.install "myx" if OS.mac? && Hardware::CPU.intel?
    bin.install "myx" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
