class Lyra < Formula
  desc "Desktop lyrics overlay and video wallpaper for macOS"
  homepage "https://github.com/GeneralD/lyra"
  url "https://github.com/GeneralD/lyra/releases/download/v2.29.9/lyra-2.29.9-macos-arm64.tar.gz"
  version "2.29.9"
  sha256 "919dfb337c244b440529029eb25ca7ddccaf3708c0fa371cdf2aaefb4070bf20"

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
    process_type :interactive
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

      Before uninstalling, stop the service so launchd does not keep
      relaunching a removed binary:
        brew services stop lyra
      or, if you registered it with `lyra service install`:
        lyra service uninstall
    EOS
  end

  test do
    system libexec/"lyra", "version"
  end
end
