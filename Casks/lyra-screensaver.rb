cask "lyra-screensaver" do
  version "0.1.0"
  sha256 "8d1038edbe85f74eea0dd63f15c4bf093a3d6b05e88be24caea3a5ec783fdd58"

  url "https://github.com/GeneralD/lyra-screensaver/releases/download/v0.1.0/LyraScreenSaver-0.1.0.zip"
  name "Lyra Screen Saver"
  desc "macOS screensaver that plays lyra's video wallpaper"
  homepage "https://github.com/GeneralD/lyra-screensaver"

  depends_on formula: "generald/tap/lyra"

  screen_saver "LyraScreenSaver.saver"
end
