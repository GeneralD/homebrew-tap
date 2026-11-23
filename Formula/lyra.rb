class Lyra < Formula
  desc "Desktop lyrics overlay and video wallpaper for macOS"
  homepage "https://github.com/GeneralD/lyra"
  url "https://github.com/GeneralD/lyra/releases/download/v2.29.3/lyra-2.29.3-macos-arm64.tar.gz"
  version "2.29.3"
  sha256 "76c5e12d2b8da9d68f66cfc439c0940ea1a4d55f0d6eaae8a36b1d0b75628c87"

  depends_on :macos
  depends_on "yt-dlp"
  depends_on "ffmpeg"

  def install
    # If archive contains pre-built binary (from GitHub Release asset)
    if File.exist?("lyra")
      libexec.install "lyra"
      Dir["*.bundle"].each { |b| libexec.install b }
    else
      # Fallback: build from source (source tarball)
      system "swift", "build", "--disable-sandbox", "-c", "release"
      build_dir = Utils.safe_popen_read("swift", "build", "--disable-sandbox", "--show-bin-path", "-c", "release").strip
      libexec.install "#{build_dir}/lyra"
      Dir["#{build_dir}/*.bundle"].each { |b| libexec.install b }
    end

    (bin/"lyra").write_env_script libexec/"lyra", {}

    output = Utils.safe_popen_read(libexec/"lyra", "completion", "zsh")
    (zsh_completion/"_lyra").write output

    output = Utils.safe_popen_read(libexec/"lyra", "completion", "bash")
    (bash_completion/"lyra").write output

    output = Utils.safe_popen_read(libexec/"lyra", "completion", "fish")
    (fish_completion/"lyra.fish").write output
  end

  service do
    run [opt_libexec/"lyra", "daemon"]
    keep_alive true
    log_path var/"log/lyra.log"
    error_log_path var/"log/lyra.log"
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
  end

  def caveats
    <<~EOS
      To start lyra as a background service:
        brew services start lyra

      Or start manually:
        lyra start
    EOS
  end

  def post_uninstall
    %w[com.generald.lyra homebrew.mxcl.lyra].each do |label|
      quiet_system "launchctl", "bootout", "gui/#{Process.uid}/#{label}"
      plist = Pathname.new(Dir.home)/"Library/LaunchAgents/#{label}.plist"
      plist.delete if plist.exist?
    end
  end

  test do
    system libexec/"lyra", "version"
  end
end
