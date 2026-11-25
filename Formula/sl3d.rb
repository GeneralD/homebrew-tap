class Sl3d < Formula
  desc "3D steam locomotive that runs across your desktop"
  homepage "https://github.com/GeneralD/sl"
  # TODO: placeholder — first GitHub Release must attach
  # dist/sl-<version>-macos-arm64.tar.gz (see `make release` in GeneralD/sl).
  url "https://github.com/GeneralD/sl/releases/download/v#{version}/sl-#{version}-macos-arm64.tar.gz"
  version "0.1.0"
  # TODO: sha256 placeholder — replace with the digest of the release tarball.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

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
