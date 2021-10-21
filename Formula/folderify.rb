class Folderify < Formula
  include Language::Python::Virtualenv

  desc "Generate pixel-perfect macOS folder icons in the native style"
  homepage "https://github.com/lgarron/folderify"
  url "https://files.pythonhosted.org/packages/02/80/b7476fe2518f0a6382d523e4a8878c3efa00c6980e9ad69fd6237e820177/folderify-2.2.3.tar.gz"
  sha256 "d6754df2f001657a01062d851e5980622adb43cafb35ab6bc7c26e62529f3291"
  license "MIT"
  # Default branch is "main" not "master"
  head "https://github.com/lgarron/folderify.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "683eeb71c2dd1f10514d9a7223493d6f99773617ede84ed8b3dfe3f396342b83"
    sha256 cellar: :any_skip_relocation, big_sur:       "9cd792687f566751d98e81b7a4c0d48ae0099273f4b99fc7743f2337f92dfe0c"
    sha256 cellar: :any_skip_relocation, catalina:      "ddf121696c9d8a78208377ea2abbba6cd45734b6f1dde623af4f87b2dd6244f8"
    sha256 cellar: :any_skip_relocation, mojave:        "b83fde65d2dc9eec57207c31ac7e6f89e5bac43426c0ce73776b55c57f0e2eb0"
  end

  depends_on "imagemagick"
  depends_on :macos
  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Copies an example icon
    cp("#{libexec}/lib/python3.9/site-packages/folderify/GenericFolderIcon.Yosemite.iconset/icon_16x16.png",
    "icon.png")
    # folderify applies the test icon to a folder
    system "folderify", "icon.png", testpath.to_s
    # Tests for the presence of the file icon
    assert_predicate testpath / "Icon\r", :exist?
  end
end
