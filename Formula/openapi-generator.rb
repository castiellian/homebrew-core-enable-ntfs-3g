class OpenapiGenerator < Formula
  desc "Generate clients, server & docs from an OpenAPI spec (v2, v3)"
  homepage "https://openapi-generator.tech/"
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/5.2.1/openapi-generator-cli-5.2.1.jar"
  sha256 "b2d46d4990af3d442e4e228e1e627b93ca371ad972f54a7e82272b0ce7968c8b"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "990cfa2b178ecdba850494c6aca3e5aad5e76303f33808d7fc6403c60b80262f"
  end

  head do
    url "https://github.com/OpenAPITools/openapi-generator.git"

    depends_on "maven" => :build
  end

  depends_on "openjdk"

  def install
    if build.head?
      system "mvn", "clean", "package", "-Dmaven.javadoc.skip=true"
      libexec.install "modules/openapi-generator-cli/target/openapi-generator-cli.jar"
    else
      libexec.install "openapi-generator-cli-#{version}.jar" => "openapi-generator-cli.jar"
    end

    (bin/"openapi-generator").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk"].opt_bin}/java" $JAVA_OPTS -jar "#{libexec}/openapi-generator-cli.jar" "$@"
    EOS
  end

  test do
    (testpath/"minimal.yaml").write <<~EOS
      ---
      swagger: '2.0'
      info:
        version: 0.0.0
        title: Simple API
      host: localhost
      basePath: /v2
      schemes:
        - http
      paths:
        /:
          get:
            operationId: test_operation
            responses:
              200:
                description: OK
    EOS
    system bin/"openapi-generator", "generate", "-i", "minimal.yaml", "-g", "openapi", "-o", "./"
  end
end
