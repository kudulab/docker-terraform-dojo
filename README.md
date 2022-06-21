# docker-terraform-dojo

[Dojo](https://github.com/kudulab/dojo) docker image with [Terraform](https://terraform.io) and supporting tools installed.
Based on alpine docker image.

Tested and released images are published to dockerhub as [kudulab/terraform-dojo](https://hub.docker.com/r/kudulab/terraform-dojo)

## Usage
1. Setup docker.
2. Install [Dojo](https://github.com/kudulab/dojo) binary.
3. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/terraform-dojo:latest"
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
 * terraform plugins: consul, openstack, aws, null, external, local, template, vault.
 * `jq` to parse JSON from bash scripts
 * `dot` to generate infrastructure graphs from terraform
 * a minimal ssh and git setup - to clone terraform modules

### Configuration
Those files are used inside the docker image:

1. `~/.ssh/` -- is copied from host to dojo's home `~/.ssh`
1. `~/.ssh/config` -- will be generated on docker container start. SSH client is configured to ignore known ssh hosts.
1. `~/.aws/` -- is copied from host to dojo's home `~/.aws`
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


## Contributing
Instructions how to update this project.

1. Create a new feature branch from the main branch
1. Work on your changes in that feature branch. If you want, describe you changes in [CHANGELOG.md](CHANGELOG.md)
1. Build your image locally to check that it succeeds: `./tasks build_local`
1. Test your image locally: `./tasks itest`. You may need to install the test framework - you can do it with `sudo ./tasks install_bats`
1. If you are happy with the results, create a PR from your feature branch to master branch

After this, someone will read your PR, merge it and ensure version bump (using `./tasks set_version`). CI pipeline will run to automatically build and test docker image, release the project and publish the docker image.

## License

Copyright 2019-2022 Ewa Czechowska, Tomasz Sętkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
