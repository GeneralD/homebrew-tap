cask "pmset-pane" do
  version "0.1.5"
  sha256 "b666efb6a8319d1d5885b012d98146b1b1fc13a1c5a270688316251d40521a0c"

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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{Dir.home}/Library/PreferencePanes/PowerManagement.prefPane"],
                   must_succeed: false
  end
end
