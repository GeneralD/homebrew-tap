class CyberboardCli < Formula
  include Language::Python::Virtualenv

  desc "Configure the AngryMiao CyberBoard R4 (keymap + LED) over USB without AM Master"
  homepage "https://github.com/GeneralD/cyberboard-cli"
  url "https://files.pythonhosted.org/packages/a4/d7/6fef0647a90e3f0c31a9cf3dc6abde5a5647cd919369d7015f82dfe9aab0/cyberboard_cli-0.1.0.tar.gz"
  sha256 "24f49518cc2ce9f3599afabb230cbe0cb6583a1e915fcf706efbf776d48d4fc3"
  license "MIT"

  depends_on "python@3.13"

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1e/7d/ae3f0a63f41e4d2f6cb66a5b57197850f919f59e558159a4dd3a818f5082/pyserial-3.5.tar.gz"
    sha256 "3c77e014170dfffbd816e6ffc205e9842efb10be9f58ec16d3e8675b4925cddb"
  end

  def install
    virtualenv_install_with_resources
    # Runs `cyberboard completion <shell>` for each shell (bash, zsh, fish by
    # default; bare shell name appended) and installs the captured script.
    generate_completions_from_executable(bin/"cyberboard", "completion")
  end

  def caveats
    <<~EOS
      Device I/O (devices, read, write, build, verify) works out of the box.

      LED authoring (the anim/led/compose render commands) needs Pillow, which
      is not bundled here because it would force a long source build on every
      install. For the full feature set, install with the LED extra via a
      wheel-based installer instead:
        uv tool install 'cyberboard-cli[led]'
        pipx install 'cyberboard-cli[led]'
    EOS
  end

  test do
    assert_match "cyberboard #{version}", shell_output("#{bin}/cyberboard --version")
    assert_match "_cyberboard", shell_output("#{bin}/cyberboard completion zsh")
  end
end
