class Dextui < Formula
  desc "A two-pane terminal UI for browsing and triaging dex tasks"
  homepage "https://github.com/DanielCarmingham/dextui"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.4.0/dextui-aarch64-apple-darwin.tar.xz"
      sha256 "095085a7d464c259c9b4216c9c9a4f4e4a7bd53e4ed84c3462fce991f3662df9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.4.0/dextui-x86_64-apple-darwin.tar.xz"
      sha256 "520cd9669dd9c8320f7d59ff318aff35b8489eec87d870fd0214f419b6419397"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.4.0/dextui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cf358c01c28ad2ee3486c4cbdda022bd175f32caf496253032597a130fb75d09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.4.0/dextui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4f062dea8438b9469c346197364d9dc1df6a4ff8a15d79dc3a37479f6f6d11d3"
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
    bin.install "dextui" if OS.mac? && Hardware::CPU.arm?
    bin.install "dextui" if OS.mac? && Hardware::CPU.intel?
    bin.install "dextui" if OS.linux? && Hardware::CPU.arm?
    bin.install "dextui" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
