class DexCli < Formula
  desc "A Rust drop-in for the dex task CLI: same store, config, GitHub and Shortcut sync, and MCP server, with concurrent-safe writes"
  homepage "https://github.com/DanielCarmingham/dexrs"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dexrs/releases/download/v0.1.2/dex-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6e028e8c13836aeba739a16d5fd6889493f678028d73563951b540f99757f537"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dexrs/releases/download/v0.1.2/dex-cli-x86_64-apple-darwin.tar.xz"
      sha256 "db94c4bc223150bb08bd92b6201cc6f9744031da22afa74d423dfee6b161c9f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dexrs/releases/download/v0.1.2/dex-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8e52646b775eb5fa2b59a74d3d787634903f046b4ece2365892a8a6b84b5581d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dexrs/releases/download/v0.1.2/dex-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5fb4836585d7c20e5127ef196d0efb65b09173c10c63f1656f5032afad77ee93"
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
      bin.install "dex", "dexrs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dex", "dexrs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dex", "dexrs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dex", "dexrs"
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
