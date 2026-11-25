class Sl3d < Formula
  desc "3D steam locomotive that runs across your desktop"
  homepage "https://github.com/GeneralD/sl"
  version "0.1.0"
  url "https://github.com/GeneralD/sl/releases/download/v#{version}/sl-#{version}-macos-arm64.tar.gz"
  sha256 "cf8fda9b0e6219e35513cff28fa7084d6e12b3c06aed3ac21c4afcdb93e3fd39"

  # The binary keeps the name `sl`; the core `sl` formula owns that name.
  conflicts_with "sl"

  def install
    bin.install "sl"
    man1.install "sl.1"
    (share/"sl"/"audio").install Dir["share/sl/audio/*"]
  end

  test do
    system "#{bin}/sl", "-v"
  end
end
