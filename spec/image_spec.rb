require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('stretch')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs Debian" do
    expect(os_version).to include("Debian")
  end

  def os_version
    command("lsb_release -a").stdout
  end
end
