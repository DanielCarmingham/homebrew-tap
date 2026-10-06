class Dexrust < Formula
  desc "Rust drop-in for the dex task CLI with concurrent-safe writes"
  homepage "https://github.com/DanielCarmingham/dexrust"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.1/dexrust-aarch64-apple-darwin.tar.xz"
      sha256 "7404dc0568d4bfa91c31439538976d579af0920c8cddaf02e34b806c4a1ca1da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.1/dexrust-x86_64-apple-darwin.tar.xz"
      sha256 "ece197ff5260850c5e3a95f4641f025c7164baf8b2dc4a7fd6cecd22bbe75aa1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.1/dexrust-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12f2c6e3911f6f7cd218e61311d60dc1ee3ca168c48d2eb95fc5729f6b5319c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.1/dexrust-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cc587a9c8583211ac56607bde80f7112db5330c0f7d319896c9d9750b78991fa"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "dex", "dexrust"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dex", "dexrust"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dex", "dexrust"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dex", "dexrust"
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
