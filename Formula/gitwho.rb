class Gitwho < Formula
  desc "Pick the right git identity and credentials for a repository, automatically, wherever it lives on disk"
  homepage "https://github.com/DanielCarmingham/gitwho"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.2/gitwho-aarch64-apple-darwin.tar.xz"
      sha256 "8091e0e36e83052b1114810871f7a194aa15a96960d5c19a2c45db1b231f1c7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.2/gitwho-x86_64-apple-darwin.tar.xz"
      sha256 "548193a4c0d10f0b3793aedbb522d45b38c0ecb6f57b050b70efc2ce5472ca31"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.2/gitwho-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "839518e557e9b4f97a04631dcdc256edb592f388576e75a3678768096b43a92e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/gitwho/releases/download/v0.4.2/gitwho-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11a7836c28b45777dd8711460123e89c1570038cfc30d85c3edd240fb15657aa"
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
