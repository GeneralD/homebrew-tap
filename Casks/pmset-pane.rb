cask "pmset-pane" do
  version "0.2.2"
  sha256 "ba05b97ec2a8ac9cfa24372511914cc5b538b265db9e80e619990e3f79ca630d"

  url "https://github.com/GeneralD/pmset-pane/releases/download/v#{version}/PMSetPane.zip"
  name "Power Management"
  desc "Preference pane for common pmset power-management settings"
  homepage "https://github.com/GeneralD/pmset-pane"

  depends_on macos: :ventura

  prefpane "PowerManagement.prefPane"

  uninstall launchctl: "io.github.generald.power-management.monitor"

  zap trash: "~/Library/LaunchAgents/io.github.generald.power-management.monitor.plist"

  # The initial release is ad-hoc signed while Developer ID notarization is
  # pending. System Settings rejects quarantined preference panes, so remove
  # the download quarantine after Homebrew has installed this known artifact.
  # Homebrew leaves a symlink to the installed bundle in the staged path; the
  # trailing slash makes xattr follow it and recurse (without it only the
  # top-level entry is cleared). Cask steps run in a sandbox that only permits
  # writes to writable_paths, and must_succeed: false makes a denial non-fatal,
  # so keep both or the quarantine silently remains. Keep the bundle name in
  # sync with the prefpane stanza above.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{staged_path}}/PowerManagement.prefPane/"],
        must_succeed:   false,
        writable_paths: ["PowerManagement.prefPane"],
        writable_base:  :prefpanedir
  end
end
