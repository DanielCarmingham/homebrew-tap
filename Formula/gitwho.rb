class Gitwho < Formula
  desc "Pick the right git identity and credentials for a repository, automatically, wherever it lives on disk"
  homepage "https://github.com/DanielCarmingham/gitwho"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.3.1/gitwho-aarch64-apple-darwin.tar.xz"
      sha256 "8562be2d7eb9506bb22e59366965ec6cdc765bcc343597618f1ba4bc6e5f17d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.3.1/gitwho-x86_64-apple-darwin.tar.xz"
      sha256 "ff295a0ffaf4ebbf78b13c485ac1358920c809ff252db3d64673a797d81fe530"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.3.1/gitwho-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "71c895226e0bc746061346e5235acda6d4c11bd28aedbdab84a52371ed1601be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.3.1/gitwho-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c322e352340c8b115f095a46c4747bd91df88e824a8fe7c59b690f6c7ac9cab0"
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
