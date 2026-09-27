class Gitwho < Formula
  desc "Pick the right git identity and credentials for a repository, automatically, wherever it lives on disk"
  homepage "https://github.com/DanielCarmingham/gitwho"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.1/gitwho-aarch64-apple-darwin.tar.xz"
      sha256 "d03f24843aa63330e1836db7f1da7a09ab22f7fb22b62960e9e9e75a936b6e82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.1/gitwho-x86_64-apple-darwin.tar.xz"
      sha256 "11d6209b0dab7f910eaf96ed069e933c2098ecd8f42c561b3d24f01970141860"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.1/gitwho-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3828fdbcdba9616e176fced2da5206c1d99b36a3f4cf6233aa5d2cfffcc30fa7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.1/gitwho-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "13abe848642859db205d9c186d506cc15c6f96f26b72427ee50fcf4932ea0e83"
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
