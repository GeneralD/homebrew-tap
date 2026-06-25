class CyberboardCli < Formula
  include Language::Python::Virtualenv

  desc "Configure the AngryMiao CyberBoard R4 (keymap + LED) over USB without AM Master"
  homepage "https://github.com/GeneralD/cyberboard-cli"
  url "https://files.pythonhosted.org/packages/b4/04/08db2a6c0eeb26cadb1e80f2ba12cf629526e754773c358757eb7b9bfd45/cyberboard_cli-0.1.1.tar.gz"
  sha256 "18b59e60c3f14939f9933e65b54db67403ad8e307a6ee82e6efde70dd24e6ca2"
  license "MIT"

  # macOS-only: device discovery is implemented against macOS serial nodes, and
  # the bundled Pillow wheel below is a macOS wheel (on_arm/on_intel dispatch by
  # CPU arch, not OS, so without this guard Linuxbrew would fetch a macOS wheel).
  depends_on :macos
  depends_on "python@3.13"

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1e/7d/ae3f0a63f41e4d2f6cb66a5b57197850f919f59e558159a4dd3a818f5082/pyserial-3.5.tar.gz"
    sha256 "3c77e014170dfffbd816e6ffc205e9842efb10be9f58ec16d3e8675b4925cddb"
  end

  # ---- keymap edit (TUI) — textual + its pure-Python dependency tree (sdist) ----
  resource "linkify-it-py" do
    url "https://files.pythonhosted.org/packages/2e/c9/06ea13676ef354f0af6169587ae292d3e2406e212876a413bf9eece4eb23/linkify_it_py-2.1.0.tar.gz"
    sha256 "43360231720999c10e9328dc3691160e27a718e280673d444c38d7d3aaa3b98b"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdit-py-plugins" do
    url "https://files.pythonhosted.org/packages/59/fc/f8d0863f8862f25602c0404d75568e89fb6b4109804645e5cdfb1be5cf56/mdit_py_plugins-0.6.1.tar.gz"
    sha256 "a2bca0f039f39dbd35fb74ae1b5f998608c437463371f0ff7f49a19a17a114d0"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/d7/47/e4501f49c178ae1d9f4a75073fda4204f52647993f075a9db4d14930e0c5/platformdirs-4.10.0.tar.gz"
    sha256 "31e761a6a0ca04faf7353ea759bdba55652be214725111e5aac52dfa29d4bef7"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/c3/b2/bc9c9196916376152d655522fdcebac55e66de6603a76a02bca1b6414f6c/pygments-2.20.0.tar.gz"
    sha256 "6757cd03768053ff99f3039c1a36d6c0aa0b263438fcab17520b30a303a82b5f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "textual" do
    url "https://files.pythonhosted.org/packages/9b/7a/c519db0aba5024f86e71e9631810bfdd6866ed2c8695bd7fa34b90e7ef59/textual-8.2.7.tar.gz"
    sha256 "658f568ff81e30ed43890c3e07520390e5cf1b4763822006e060656b0a88f105"
  end

  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  resource "uc-micro-py" do
    url "https://files.pythonhosted.org/packages/78/67/9a363818028526e2d4579334460df777115bdec1bb77c08f9db88f6389f2/uc_micro_py-2.0.0.tar.gz"
    sha256 "c53691e495c8db60e16ffc4861a35469b0ba0821fe409a8a7a0a71864d33a811"
  end

  # ---- LED authoring (anim/led/compose) — Pillow as a prebuilt wheel ----
  # Shipped as an arch-specific cp313 wheel (nounzip) so installs take seconds
  # instead of a multi-minute source build of the imaging C extensions.
  resource "pillow" do
    on_arm do
      url "https://files.pythonhosted.org/packages/71/43/905a14a8b17fdb1ccb58d282454490662d2cb89a6bfec26af6d3520da5ec/pillow-12.2.0-cp313-cp313-macosx_11_0_arm64.whl", using: :nounzip
      sha256 "56b25336f502b6ed02e889f4ece894a72612fe885889a6e8c4c80239ff6e5f5f"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/34/46/6c717baadcd62bc8ed51d238d521ab651eaa74838291bda1f86fe1f864c9/pillow-12.2.0-cp313-cp313-macosx_10_13_x86_64.whl", using: :nounzip
      sha256 "5d2fd0fa6b5d9d1de415060363433f28da8b1526c1c129020435e186794b3795"
    end
  end

  def install
    venv = virtualenv_create(libexec, "python3.13")
    # Pillow ships as a prebuilt wheel; install every other resource from sdist.
    venv.pip_install resources.reject { |r| r.name == "pillow" }
    resource("pillow").stage do
      venv.pip_install Dir["*.whl"].first
    end
    venv.pip_install_and_link buildpath
    # Runs `cyberboard completion <shell>` for each shell (bash, zsh, fish by
    # default; bare shell name appended) and installs the captured script.
    generate_completions_from_executable(bin/"cyberboard", "completion")
  end

  def caveats
    <<~EOS
      All keyboard features work out of the box: device I/O (devices, read,
      write, build, verify), keymap edit (TUI), and LED authoring
      (anim/led/compose).

      Two optional extras are not bundled and degrade gracefully without them:
        - jsonschema, used by `verify` (falls back to a basic structural check)
        - the standalone `cyberboard-mcp` server (the `mcp` package)
      Add them with a wheel-based installer if you need them:
        uv tool install 'cyberboard-cli[verify,mcp]'
    EOS
  end

  test do
    assert_match "cyberboard #{version}", shell_output("#{bin}/cyberboard --version")
    assert_match "_cyberboard", shell_output("#{bin}/cyberboard completion zsh")
    # The bundled extras must import — this is what brew-only installs were missing.
    system libexec/"bin/python", "-c", "import textual, PIL"
  end
end
