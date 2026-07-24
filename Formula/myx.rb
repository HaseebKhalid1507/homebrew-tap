class Myx < Formula
  desc "A lean, beautiful terminal Spotify player"
  homepage "https://github.com/HaseebKhalid1507/Myx"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.2.4/myx-aarch64-apple-darwin.tar.gz"
      sha256 "50a87cee41b58251549c15ca63024bfa5c8c50ee2ec8b7d8afd7c0e20eb59984"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.2.4/myx-x86_64-apple-darwin.tar.gz"
      sha256 "50ee276ed31b12384de363265a278c88335fa3b43dd029615f46d95a1e72291c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.2.4/myx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "45143fe0bfb16376425f629bf33ddd54044063eb24e19c698caefad572c0c3f7"
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
