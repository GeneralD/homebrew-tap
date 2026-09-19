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
  # Homebrew leaves a symlink to the installed bundle in the staged path; the
  # trailing slash makes xattr follow it and recurse (without it only the
  # top-level entry is cleared). Cask steps run in a sandbox that only permits
  # writes to writable_paths, and must_succeed: false makes a denial non-fatal,
  # so keep both or the quarantine silently remains. Keep the bundle name in
  # sync with the screen_saver stanza above.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{staged_path}}/LyraScreenSaver.saver/"],
        must_succeed:   false,
        writable_paths: ["LyraScreenSaver.saver"],
        writable_base:  :screen_saverdir
  end
end
