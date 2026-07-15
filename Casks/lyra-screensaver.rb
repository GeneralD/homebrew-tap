cask "lyra-screensaver" do
  version "0.1.1"
  sha256 "7d9f298aee3cca6bf4952b982f0596edc28778e1897cf22ec49ce23c48df44b6"

  url "https://github.com/GeneralD/lyra-screensaver/releases/download/v0.1.1/LyraScreenSaver-0.1.1.zip"
  name "Lyra Screen Saver"
  desc "macOS screensaver that plays lyra's video wallpaper"
  homepage "https://github.com/GeneralD/lyra-screensaver"

  depends_on formula: "generald/tap/lyra"

  screen_saver "LyraScreenSaver.saver"

  # The .saver ships unsigned (ad-hoc, not notarized). Homebrew quarantines the
  # download, and macOS 26's wallpaper-agent screensaver host then silently
  # refuses to instantiate the view -- the screen stays black. Strip the
  # quarantine from the installed bundle so it loads. The proper long-term fix
  # is Developer ID signing + notarization in CI.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{Dir.home}/Library/Screen Savers/LyraScreenSaver.saver"],
                   must_succeed: false
  end
end
