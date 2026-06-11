cask "video-screen-saver" do
  version "1.0.2"
  sha256 "09b751c455c10980f0ecc0e9d77f6a2886b86de4e2c5e19880fe46c2d0a543c5"

  url "https://github.com/GeneralD/VideoScreenSaver/releases/download/v1.0.2/VideoScreenSaver-1.0.2.zip"
  name "VideoScreenSaver"
  desc "macOS screensaver that plays a video file in a loop"
  homepage "https://github.com/GeneralD/VideoScreenSaver"

  screen_saver "VideoScreenSaver.saver"
end
