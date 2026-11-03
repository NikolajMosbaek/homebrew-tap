class Declutter < Formula
  desc "Review AI-generated diffs with comments, tests, imports, logging and formatting toggled in and out"
  homepage "https://github.com/NikolajMosbaek/declutter-diff"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.5/declutter-diff-aarch64-apple-darwin.tar.xz"
      sha256 "9648eb57e30fde7285ce48ade9871ff7a6dc5877c6de3e3728e7ea6904432688"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.5/declutter-diff-x86_64-apple-darwin.tar.xz"
      sha256 "672c6abd81e460363d42e95a425c0022ef02b38cc8582538cbf95e869b7aa4de"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.5/declutter-diff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dcde5d98274f03a1f869982d584bc076d15c4bd6d2574ec217e4de8bef66d246"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.5/declutter-diff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2f95a61b260d5c69366092204167ad599005dccb62598864cda3e0527f5e66c5"
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
