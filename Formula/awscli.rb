class Awscli < Formula
  include Language::Python::Virtualenv

  desc "Official Amazon AWS command-line interface"
  homepage "https://aws.amazon.com/cli/"
  license "Apache-2.0"

  stable do
    url "https://github.com/aws/aws-cli/archive/2.2.47.tar.gz"
    sha256 "ec361dffbd79f6c4f9c97bc17b9a8792d35dbfdccc663e25d8b27e6ccf0289cf"

    # Botocore v2 is not available on PyPI and version commits are not tagged. One way to update:
    # 1. Get `botocore` version at https://github.com/aws/aws-cli/blob/#{version}/setup.cfg
    # 2. Get commit matching version at https://github.com/boto/botocore/commits/v2
    resource "botocore" do
      url "https://github.com/boto/botocore/archive/7083e5c204e139dc41f646e0ad85286b5e7c0c23.tar.gz"
      sha256 "5810653b025bc5041914c2abf1e7e7ae0f15cdc83fc21d7ac3b0ee1b5814fd4f"
      version "2.0.0dev155"
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "a609b8f06ddf5fbaae52f611ea118d41691e1ef8d432ec518cef140e908c328d"
    sha256 cellar: :any,                 big_sur:       "5488bdf6e6404fa94af4beda53efefc9e4527c72f1378cc10ea46e4032595850"
    sha256 cellar: :any,                 catalina:      "a5114b36d50aa13db1c61f56828dbdd34104882e5626d8d77ae6976bc6f35ae4"
    sha256 cellar: :any,                 mojave:        "62131171912023710b1f9e615d19ee7f0f2472744c3110eda1f45a08f04b3cce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b241a42810765085a7d4a205ae35a58015a42a0a202138b41505ce507e30abef"
  end

  head do
    url "https://github.com/aws/aws-cli.git", branch: "v2"

    resource "botocore" do
      url "https://github.com/boto/botocore.git", branch: "v2"
    end
  end

  depends_on "cmake" => :build
  depends_on "python@3.9"
  depends_on "six"

  uses_from_macos "groff"

  # Python resources should be updated based on setup.cfg. One possible way is:
  # 1. Download source tarball
  # 2. Remove `botocore` from setup.cfg
  # 3. At top of source directory, run `pipgrip . --sort`
  # 4. Ignore old `botocore` v1 and `six`. Update all other PyPI packages

  resource "awscrt" do
    url "https://files.pythonhosted.org/packages/9f/e2/5a0b096fb73f2b33ad2cc7392d33d365d3b78b295b21dda5792dd481b38f/awscrt-0.11.24.tar.gz"
    sha256 "b8aa68bca404bf0085be0570eff5b542d01f7e8e3c0f9b0859abfe5e070162ff"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2e/92/87bb61538d7e60da8a7ec247dc048f7671afe17016cd0008b3b710012804/cffi-1.14.6.tar.gz"
    sha256 "c9a875ce9d7fe32887784274dd533c57909b7b1dcadcc128a2ac21331a9765dd"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/82/75/f2a4c0c94c85e2693c229142eb448840fba0f9230111faa889d1f541d12d/colorama-0.4.3.tar.gz"
    sha256 "e96da0d330793e2cb9485e9ddfd918d456036c7149416295932478192f4436a1"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/d4/85/38715448253404186029c575d559879912eb8a1c5d16ad9f25d35f7c4f4c/cryptography-3.3.2.tar.gz"
    sha256 "5a60d3780149e13b7a6ff7ad6526b38846354d11a15e21068e57073e29e19bed"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/a6/a4/75064c334d8ae433445a20816b788700db1651f21bdb0af33db2aab142fe/distro-1.5.0.tar.gz"
    sha256 "0e58756ae38fbd8fc3020d54badb8eae17c5b9dcbed388b17bb55b8a5928df92"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/93/22/953e071b589b0b1fee420ab06a0d15e5aa0c7470eb9966d60393ce58ad61/docutils-0.15.2.tar.gz"
    sha256 "a2aeea129088da402665e92e0b25b04b073c04b2dce4ab65caaa38b7ce2e1a99"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/3c/56/3f325b1eef9791759784aa5046a8f6a1aff8f7c898a2e34506771d3b99d8/jmespath-0.10.0.tar.gz"
    sha256 "b85d0567b8666149a93172712e68920734333c0ce7e89b78b3e987f71e5ed4f9"
  end

  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/0c/37/7ad3bf3c6dbe96facf9927ddf066fdafa0f86766237cff32c3c7355d3b7c/prompt_toolkit-2.0.10.tar.gz"
    sha256 "f15af68f66e664eaa559d4ac8a928111eebd5feda0c11738b5998045224829db"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "ruamel-yaml" do
    url "https://files.pythonhosted.org/packages/9a/ee/55cd64bbff971c181e2d9e1c13aba9a27fd4cd2bee545dbe90c44427c757/ruamel.yaml-0.15.100.tar.gz"
    sha256 "8e42f3067a59e819935a2926e247170ed93c8f0b2ab64526f888e026854db2e4"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/27/90/f467e516a845cf378d85f0a51913c642e31e2570eb64b352c4dc4c6cbfc7/s3transfer-0.4.2.tar.gz"
    sha256 "cb022f4b16551edebbb31a377d3f09600dbada7363d8c5db7976e7f47732e1b2"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/80/be/3ee43b6c5757cabea19e75b8f46eaf05a2f5144107d7db48c7cf3a864f73/urllib3-1.26.7.tar.gz"
    sha256 "4987c65554f7a2dbf30c18fd48778ef124af6fab771a377103da0585e2336ece"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/25/9d/0acbed6e4a4be4fc99148f275488580968f44ddb5e69b8ceb53fc9df55a0/wcwidth-0.1.9.tar.gz"
    sha256 "ee73862862a156bf77ff92b09034fc4825dd3af9cf81bc5b360668d425f3c5f1"
  end

  def install
    # The `awscrt` package uses its own libcrypto.a on Linux. When building _awscrt.*.so,
    # Homebrew's default environment causes issues, which may be due to `openssl` flags.
    # This causes installation to fail while running `scripts/gen-ac-index` with error:
    # ImportError: _awscrt.cpython-39-x86_64-linux-gnu.so: undefined symbol: EVP_CIPHER_CTX_init
    # As workaround, add relative path to local libcrypto.a before openssl's so it gets picked.
    if OS.linux?
      ENV.prepend "CFLAGS", "-I./build/deps/install/include"
      ENV.prepend "LDFLAGS", "-L./build/deps/install/lib"
    end

    # venv.pip_install_and_link cannot be used due to requiring the `--no-build-isolation` flag
    # See upstream build instructions: https://github.com/aws/aws-cli/blob/2.2.44/requirements-runtime.txt
    # This should be able to be reversed in future: https://github.com/Homebrew/homebrew-core/pull/86527#issuecomment-936763994
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources

    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--no-binary", ":all:",
                              "--ignore-installed",
                              "--no-build-isolation",
                              buildpath

    bin.install_symlink Dir[libexec/"bin/aws*"]

    pkgshare.install "awscli/examples"

    rm Dir["#{bin}/{aws.cmd,aws_bash_completer,aws_zsh_completer.sh}"]
    bash_completion.install "bin/aws_bash_completer"
    zsh_completion.install "bin/aws_zsh_completer.sh"
    (zsh_completion/"_aws").write <<~EOS
      #compdef aws
      _aws () {
        local e
        e=$(dirname ${funcsourcetrace[1]%:*})/aws_zsh_completer.sh
        if [[ -f $e ]]; then source $e; fi
      }
    EOS
  end

  def caveats
    <<~EOS
      The "examples" directory has been installed to:
        #{HOMEBREW_PREFIX}/share/awscli/examples
    EOS
  end

  test do
    assert_match "topics", shell_output("#{bin}/aws help")
    assert_includes Dir["#{libexec}/lib/python3.9/site-packages/awscli/data/*"],
                    "#{libexec}/lib/python3.9/site-packages/awscli/data/ac.index"
  end
end
