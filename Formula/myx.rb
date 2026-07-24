class Myx < Formula
  desc "A lean, beautiful terminal Spotify player"
  homepage "https://github.com/HaseebKhalid1507/Myx"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.2.3/myx-aarch64-apple-darwin.tar.gz"
      sha256 "29abcb330472757f43140a2ed2a9c98b40947fb1586af5275b16f3fd2a957a67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.2.3/myx-x86_64-apple-darwin.tar.gz"
      sha256 "46c857f2dc60848a2c4cd2dc20bf8d636417ebfd89afd0b47613d6f406775a76"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.2.3/myx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d00a516d30bd7d625128fc839e12bbc8a55a231911e9a6851ee58153e316456a"
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
