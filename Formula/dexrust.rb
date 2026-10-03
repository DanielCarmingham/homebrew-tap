class Dexrust < Formula
  desc "A Rust drop-in for the dex task CLI: same store, config, GitHub and Shortcut sync, and MCP server, with concurrent-safe writes"
  homepage "https://github.com/DanielCarmingham/dexrust"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.0/dexrust-aarch64-apple-darwin.tar.xz"
      sha256 "1f0651832e907a20f153ba563995b8063ea423a74e65aff4c9a1a07d1c722b4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.0/dexrust-x86_64-apple-darwin.tar.xz"
      sha256 "7039f7d679146dcf2b97dda871ba12343b38e7b2a73ee6a69facd23aaa847833"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.0/dexrust-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a440fe159d88aebc28aba5313edff87f233f3178a909f630f704a10aa44e74d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dexrust/releases/download/v0.2.0/dexrust-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c58369bb7ca142995008f4cbe918e4977cad083ecb2873af11b805f784bba17b"
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
