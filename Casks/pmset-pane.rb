cask "pmset-pane" do
  version "0.1.0"
  sha256 "a4a917f7e43a201b3143138e995dd20dbb2419cee49e5b28565c29cdbf42e56a"

  url "https://github.com/GeneralD/pmset-pane/releases/download/v#{version}/PMSetPane.zip"
  name "PMSet Pane"
  desc "Preference pane for common pmset power-management settings"
  homepage "https://github.com/GeneralD/pmset-pane"

  depends_on macos: ">= :ventura"

  prefpane "PMSetPane.prefPane"
end
