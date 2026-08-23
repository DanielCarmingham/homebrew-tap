class Dextui < Formula
  desc "A terminal UI for browsing and triaging dex tasks, across every repo and worktree you register"
  homepage "https://github.com/DanielCarmingham/dextui"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.2/dextui-aarch64-apple-darwin.tar.xz"
      sha256 "b97eb8d0e666f113b70dc083ab71d13201531d8710ba4767c583bda267de589f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.2/dextui-x86_64-apple-darwin.tar.xz"
      sha256 "da0217d1009e00c79a74a2ed211e5b39663f2cc1c82647d23982b4ee6c45a05c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.2/dextui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e0ca5e7351533c3294e8f8fc4a8de6d399fcdc956781435e98d36ddfff3a5bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DanielCarmingham/dextui/releases/download/v0.5.2/dextui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "59305a4be17fd86aec680978da8934714b44d6cd565f3939d665f42dbeb827a1"
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
