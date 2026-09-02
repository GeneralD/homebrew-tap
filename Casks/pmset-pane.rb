cask "pmset-pane" do
  version "0.1.2"
  sha256 "ed4ac7a3c182381bd7215c7be9745ed8cb1b8a0f3f56231476858094f354ede9"

  url "https://github.com/GeneralD/pmset-pane/releases/download/v#{version}/PMSetPane.zip"
  name "Power Management"
  desc "Preference pane for common pmset power-management settings"
  homepage "https://github.com/GeneralD/pmset-pane"

  depends_on macos: :ventura

  prefpane "PowerManagement.prefPane"

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
