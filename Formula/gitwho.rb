class Gitwho < Formula
  desc "Pick the right git identity and credentials for a repository, automatically, wherever it lives on disk"
  homepage "https://github.com/DanielCarmingham/gitwho"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.3/gitwho-aarch64-apple-darwin.tar.xz"
      sha256 "3e0e80c0d79dc1d63e70dc05786ac02396c64f454be3ef4e56c6c20cb674daa5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.3/gitwho-x86_64-apple-darwin.tar.xz"
      sha256 "7c9e07395493a014ef344a0d56651e92b7859fb2ef633bfbba0279eec06fdace"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.3/gitwho-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "01c420a8e1d0fa5be3e3b2e4f025093897570f9b664a397ad2c2db455e95d55e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.3/gitwho-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca54a941e53e92b78015dc44ddb9e81385850b02f517a1dddcafe635b37051db"
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
