class Declutter < Formula
  desc "Review AI-generated diffs with comments, tests, imports, logging and formatting toggled in and out"
  homepage "https://github.com/NikolajMosbaek/declutter-diff"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.2/declutter-diff-aarch64-apple-darwin.tar.xz"
      sha256 "72e0a6bce928bb3afd9b9178006418b17463a0d8c3a9fa0c967816db767461cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.2/declutter-diff-x86_64-apple-darwin.tar.xz"
      sha256 "1b7934fd5256339f2c8b3daa4d39cf2d5cc36c87d207c8cbf0d8e205b610a2e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.2/declutter-diff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7965b52198402db61bd3a487c478b5587179afd2d36f6b20ff8951230603b917"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.2/declutter-diff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d164ccbd91078e7b908106c9ca3eb7e5513e2487c7683d3b7428fe80ca397f86"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
