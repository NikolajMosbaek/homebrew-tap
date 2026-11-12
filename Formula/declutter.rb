class Declutter < Formula
  desc "Review AI-generated diffs with comments, tests, imports, logging and formatting toggled in and out"
  homepage "https://github.com/NikolajMosbaek/declutter-diff"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.2.0/declutter-diff-aarch64-apple-darwin.tar.xz"
      sha256 "48deec0e757ccc8a029b50c218108448a1b8bdca4fc8100f43a3e0e78861fb8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.2.0/declutter-diff-x86_64-apple-darwin.tar.xz"
      sha256 "77d2edcb4dd8c8131424603df57e75da954691b725e76e524355f2dc69d4a64d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.2.0/declutter-diff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e806ba93aaed499d6c20af36a323f334f7e0759c66fbdb7e21cf4db57c638484"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.2.0/declutter-diff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e208e20f5526223f54dedbda9871d838861cfa4cfc5dadbef388e3977419dbfd"
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
