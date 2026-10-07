class Declutter < Formula
  desc "Review AI-generated diffs with comments, tests, imports, logging and formatting toggled in and out"
  homepage "https://github.com/NikolajMosbaek/declutter-diff"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.3/declutter-diff-aarch64-apple-darwin.tar.xz"
      sha256 "9e57dfabacabfc415bd1d4fa65354c9d8e060308759e9bd5665cfed2d2a73519"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.3/declutter-diff-x86_64-apple-darwin.tar.xz"
      sha256 "5d33d3217d14ea70aa9da933d42a5a2a05f1f19d471baad22cbdfa824669d955"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.3/declutter-diff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "abd1bf6a1ac8e9126470448de8086607b36df67d6e7c2e8bb77f35c778fbbb1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.3/declutter-diff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c71a009e5a3cd95f7922644556f8ad0a69b264741ba3ee11bd1ebdf807604b01"
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
      bin.install "declutter"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "declutter"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "declutter"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "declutter"
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
