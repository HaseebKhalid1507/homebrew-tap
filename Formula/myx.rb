class Myx < Formula
  desc "A lean, beautiful terminal Spotify player"
  homepage "https://github.com/HaseebKhalid1507/Myx"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.1.3/myx-aarch64-apple-darwin.tar.gz"
      sha256 "865ca8dfd8d806043de98b9ca5bafc3f7c06854ed1ae74093bf522abbca93fef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.1.3/myx-x86_64-apple-darwin.tar.gz"
      sha256 "410e82154a89930451c9747345f42f44042d37063d22c647136be6af4fffbe0a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.1.3/myx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f1c0c73564d58d8a1155d0a09ec638cc2ca41b163394cf8eb3441a0117252040"
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
