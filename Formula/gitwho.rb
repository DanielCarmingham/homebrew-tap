class Gitwho < Formula
  desc "Pick the right git identity and credentials for a repository, automatically, wherever it lives on disk"
  homepage "https://github.com/DanielCarmingham/gitwho"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.0/gitwho-aarch64-apple-darwin.tar.xz"
      sha256 "7002df9e3472dbe47e87b90d5abcc0f93ff89ac55f07adbf3ddd012a3e31c8d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.0/gitwho-x86_64-apple-darwin.tar.xz"
      sha256 "c7f947529b0cd17450a25a77a75090fb4ee086df85a789d9a94e74d9b74dd87f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.0/gitwho-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b227aa4736446ba7d505b09640a9310df77a8e683e93473f1ca4151f86518a34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.0/gitwho-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "37d71c9cfc81745781946dc80e8729abc134def5d49e4ad1af86599eea67802b"
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
      bin.install "gitwho"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gitwho"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gitwho"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gitwho"
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
