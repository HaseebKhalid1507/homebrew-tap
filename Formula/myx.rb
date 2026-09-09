class Myx < Formula
  desc "A lean, beautiful terminal Spotify player"
  homepage "https://github.com/HaseebKhalid1507/Myx"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.5.0/myx-aarch64-apple-darwin.tar.gz"
      sha256 "796248ed553ec752a108705200c1a58a9b92ae11d7e779e1d34d13f1ef16f4fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.5.0/myx-x86_64-apple-darwin.tar.gz"
      sha256 "20fd06bc686fa4e1f56ae5ddb11e0fcf37310c49a0694a162ff560d3c7ea75be"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/HaseebKhalid1507/Myx/releases/download/v0.5.0/myx-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "00d00f235269051c8b59f04595c6b63b2785ad23054f385a18a51fa10ed10ea2"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "myx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "myx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "myx"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
