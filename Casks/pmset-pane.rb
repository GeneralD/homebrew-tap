cask "pmset-pane" do
  version "0.1.0"
  sha256 "a4a917f7e43a201b3143138e995dd20dbb2419cee49e5b28565c29cdbf42e56a"

  url "https://github.com/GeneralD/pmset-pane/releases/download/v#{version}/PMSetPane.zip"
  name "PMSet Pane"
  desc "Preference pane for common pmset power-management settings"
  homepage "https://github.com/GeneralD/pmset-pane"

  depends_on macos: :ventura

  prefpane "PMSetPane.prefPane"

  # The initial release is ad-hoc signed while Developer ID notarization is
  # pending. System Settings rejects quarantined preference panes, so remove
  # the download quarantine after Homebrew has installed this known artifact.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{Dir.home}/Library/PreferencePanes/PMSetPane.prefPane"],
                   must_succeed: false
  end
end
