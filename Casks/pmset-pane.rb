cask "pmset-pane" do
  version "0.1.3"
  sha256 "c68e7531e9d1f6fbe320bb0c200f6021bc4bc7dede8144901b0808dda3cd8c6c"

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
