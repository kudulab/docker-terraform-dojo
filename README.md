# docker-terraform-dojo

[Dojo](https://github.com/ai-traders/dojo) docker image with [Terraform](https://terraform.io) and supporting tools installed.
Based on alpine docker image.

Tested and released images are published to dockerhub as [kudulab/terraform-dojo](https://cloud.docker.com/u/kudulab/repository/docker/kudulab/terraform-dojo)

## Usage
1. Setup docker.
2. Install [Dojo](https://github.com/ai-traders/dojo) binary.
3. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/terraform-dojo:1.0.0"
```
4. Create and enter the container by running `dojo` at the root of project.
5. Work with terraform as usual:
```bash
terraform --version
terraform init
terraform plan
```

By default, current directory in docker container is `/dojo/work`.

## Specification

 * base image is alpine, to make this image as small as possible
 * terraform binary on the PATH
 * terraform plugins: consul, openstack, aws, null, external, local, template.
 * `jq` to parse JSON from bash scripts
 * `dot` to generate infrastructure graphs from terraform
 * a minimal ssh and git setup - to clone terraform modules

### Configuration
Those files are used inside the docker image:

1. `~/.ssh/` -- is copied from host to dojo's home `~/.ssh`
1. `~/.ssh/config` -- will be generated on docker container start. SSH client is configured to ignore known ssh hosts.
2. `~/.gitconfig` -- if exists locally, will be copied
3. `~/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/dojo/work`.
4. For openstack access - environment variables must be locally set:
 `[ 'OS_AUTH_URL', 'OS_TENANT_NAME', 'OS_USERNAME',
   'OS_PASSWORD']`. Dojo will pass them to the docker image.
5. For AWS access `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` must be set.

To enable debug output:
```
OS_DEBUG=1 TF_LOG=debug
```

## Development

### Why not just use official terraform image?
So that packer-dojo and terraform-dojo are similar and thus easier to maintain.

### Dependencies
* Bash
* Docker daemon
* Dojo

Full spec is [ops-base](https://github.com/kudulab/ops-base)

### Lifecycle
1. In a feature branch:
 * you make changes
 * and run tests:
     * `./tasks build`
     * `./tasks itest`
1. You decide that your changes are ready and you:
 * merge into master branch
 * run locally:
   * `./tasks set_version` to set version in CHANGELOG, bump patch version
   * e.g. `./tasks set_version 1.2.3` to set version in CHANGELOG to 1.2.3
 * push to master onto private git server
1. CI server (GoCD) tests and releases.
