# frozen_string_literal: true

class VaultClient < Formula
  version = "v1.1.4"

  desc "Command-line interface to HashiCorp's Vault"
  homepage "https://github.com/adfinis-sygroup/vault-client"
  url "https://github.com/adfinis-sygroup/vault-client/archive/#{version}.tar.gz"
  sha256 "086e52955aebadd5a53e149409087576ff7090b17bbb373096873162d25871a8"

  bottle do
    cellar :any_skip_relocation
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath

    cd buildpath do
      system "make", "build"
      bin.install "./vc"
      prefix.install_metafiles
     end
  end

  test do
    output = shell_output("#{bin}/vc --help 2>&1")
    assert_match "Usage: vc [--version] [--help] <command> [<args>]", output
  end
end
