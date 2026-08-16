class Dextui < Formula
  desc "A terminal UI for browsing and triaging dex tasks, across every repo and worktree you register"
  homepage "https://github.com/DanielCarmingham/dextui"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.1/dextui-aarch64-apple-darwin.tar.xz"
      sha256 "e086750dcfd4c34891b31c86e81a3910d1b630060ea6ed22289c62213e0f1bfe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.1/dextui-x86_64-apple-darwin.tar.xz"
      sha256 "8404894e54efe421b319be8cf53926af262e5d4bc3309628a1208b0cdb606693"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.1/dextui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "75785287f552bdeaccff570a869efad02589b1354b28f90a8a558c1e96a67fd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.1/dextui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "125c32e4cdd3ee3f8839223305c8d97b15b9deabfacb14f31e38c487c1f856ad"
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
      bin.install "dextui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dextui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dextui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dextui"
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
