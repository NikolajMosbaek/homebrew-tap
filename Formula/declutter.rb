class Declutter < Formula
  desc "Review AI-generated diffs with comments, tests, imports, logging and formatting toggled in and out"
  homepage "https://github.com/NikolajMosbaek/declutter-diff"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.4/declutter-diff-aarch64-apple-darwin.tar.xz"
      sha256 "f6541264441907c85665f5edbb5358442a87f8d63a7186ef69ed309c80e0d26b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.4/declutter-diff-x86_64-apple-darwin.tar.xz"
      sha256 "e4b8c0d8a3164484a22149023ed5c2dbc3c69902fb8509e00b4ca8f2595273a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.4/declutter-diff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "885463eb9df254f1c3a5cc0fda09749df2a5d9c85f3d19338d2d801da70048a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NikolajMosbaek/declutter-diff/releases/download/v0.1.4/declutter-diff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "80e1acf4e86122977e5e8c0281823d1b4ba6dbed56da1377c023c9b065692adb"
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
