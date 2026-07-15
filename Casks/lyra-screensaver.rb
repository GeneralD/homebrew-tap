cask "lyra-screensaver" do
  version "0.1.1"
  sha256 "7d9f298aee3cca6bf4952b982f0596edc28778e1897cf22ec49ce23c48df44b6"

  url "https://github.com/GeneralD/lyra-screensaver/releases/download/v0.1.1/LyraScreenSaver-0.1.1.zip"
  name "Lyra Screen Saver"
  desc "macOS screensaver that plays lyra's video wallpaper"
  homepage "https://github.com/GeneralD/lyra-screensaver"

  depends_on formula: "generald/tap/lyra"

  screen_saver "LyraScreenSaver.saver"
end
