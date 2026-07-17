class LyraDynamicWallpaper < Formula
  desc "Turn lyra's video wallpapers into a macOS Dynamic Desktop (time-of-day HEIC)"
  homepage "https://github.com/GeneralD/lyra-dynamic-wallpaper"
  url "https://github.com/GeneralD/lyra-dynamic-wallpaper/releases/download/v0.2.0/lyra-dynamic-wallpaper-0.2.0-macos-arm64.tar.gz"
  version "0.2.0"
  sha256 "09194bd79e1c0cb048e4b115cdde69a57fe9c64558d3980909783342191524b9"

  depends_on :macos
  # Companion tool: reads lyra's config and wallpaper cache (and lyra brings
  # yt-dlp/ffmpeg for resolving videos that are not cached yet).
  depends_on "generald/tap/lyra"

  def install
    # If archive contains pre-built binary (from GitHub Release asset)
    if File.exist?("lyra-dynamic-wallpaper")
      libexec.install "lyra-dynamic-wallpaper"
      Dir["*.bundle"].each { |b| libexec.install b }
    else
      # Fallback: build from source (source tarball)
      system "swift", "build", "--disable-sandbox", "-c", "release"
      build_dir = Utils.safe_popen_read("swift", "build", "--disable-sandbox", "--show-bin-path", "-c", "release").strip
      libexec.install "#{build_dir}/lyra-dynamic-wallpaper"
      Dir["#{build_dir}/*.bundle"].each { |b| libexec.install b }
    end

    (bin/"lyra-dynamic-wallpaper").write_env_script libexec/"lyra-dynamic-wallpaper", {}

    output = Utils.safe_popen_read(libexec/"lyra-dynamic-wallpaper", "--generate-completion-script", "zsh")
    (zsh_completion/"_lyra-dynamic-wallpaper").write output

    output = Utils.safe_popen_read(libexec/"lyra-dynamic-wallpaper", "--generate-completion-script", "bash")
    (bash_completion/"lyra-dynamic-wallpaper").write output

    output = Utils.safe_popen_read(libexec/"lyra-dynamic-wallpaper", "--generate-completion-script", "fish")
    (fish_completion/"lyra-dynamic-wallpaper.fish").write output
  end

  def caveats
    <<~EOS
      Generates from your existing lyra config ([wallpaper] items):
        lyra-dynamic-wallpaper --apply

      The lock screen follows the desktop wallpaper on default macOS setups.
    EOS
  end

  test do
    system libexec/"lyra-dynamic-wallpaper", "--help"
  end
end
