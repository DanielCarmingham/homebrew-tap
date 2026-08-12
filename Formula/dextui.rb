class Dextui < Formula
  desc "A terminal UI for browsing and triaging dex tasks, across every repo and worktree you register"
  homepage "https://github.com/DanielCarmingham/dextui"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.0/dextui-aarch64-apple-darwin.tar.xz"
      sha256 "2b0acf6dbc510a8f0c45846b48b167ec2bce9712c0d64e52960e03e61f07461b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.0/dextui-x86_64-apple-darwin.tar.xz"
      sha256 "ac60ca3792b6afaec39facd20c118b8699f8f90859fe9da29741747d7a68afad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.0/dextui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2b2e69b8e54ce12a04346ce82ce658fe7a80807f693e36091d564e162dfd38e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.0/dextui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f7d7d8d1c063ffd79b4ba610955dc60985fde5f3fa66211629af91b1cb72935"
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
