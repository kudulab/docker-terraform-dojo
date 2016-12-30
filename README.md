# docker-terraformide

Produces IDE docker image with Terraform and Graphviz installed.

It was supposed to use ai_chefdev cookbook, but I decided to make it as
 easy as possible (and as small as possible to). Based on alpine docker image.

## Usage
1. Install [IDE](https://github.com/ai-traders/ide)
2. Provide an Idefile:
```
IDE_DOCKER_IMAGE="docker-registry.ai-traders.com/terraformide:0.3.0"
```
3. Run, example commands:
```bash
ide terraform --version
```

By default, current directory in docker container is `/ide/work`.

### Configuration
Those files are used inside gitide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
 (but the whole `~/.ssh` will be copied)
2. `~/.gitconfig` -- if exists locally, will be copied
3. `~/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.
4. Environment variables must be locally set:
 `[ 'OS_AUTH_URL', 'OS_TENANT_NAME', 'OS_USERNAME',
   'OS_PASSWORD']`. Ide will pass them to packeride.

## Development

### Why not just use official terraform image?
So that packeride and terraformide are similar and thus easier to maintain.

### Dependencies
Bash, IDE, and Docker daemon. Needed is docker IDE image with:
  * Docker daemon
  * IDE (we run IDE in IDE; for end user tests)
  * ruby

All the below tests are supposed to be invoked inside an IDE docker image:
```bash
ide
bundle install
```

### Fast tests
```bash
# Run repocritic linting.
bundle exec rake style

# Build a docker image with IDE configs only and test it
bundle exec rake build_configs_image && bundle exec rake test_ide_configs
```

**OR** you can run those (Test-Kitchen) tests also this way (1 tests suite example):
```bash
bundle exec kitchen converge configs-docker
bundle exec kitchen verify configs-docker
bundle exec kitchen destroy configs-docker
```

Here `.kitchen.yml` is used.
```


### Build
Build docker image. This will generate imagerc file.

```bash
bundle exec rake build
```

### Long tests
Having built the docker image, there are 2 kind of tests available:

```bash
# Test-Kitchen tests, test that IDE configs are set and that system packages are
# installed
bundle exec rake kitchen


# RSpec tests invoke ide command using Idefiles and the just built docker
# image
bundle exec rake install_ide
bundle exec rake end_user
```

**OR** you can run Test-Kitchen tests also this way:
```bash
source image/imagerc
KITCHEN_YAML="/ide/work/.kitchen.image.yml" bundle exec kitchen converge configs
KITCHEN_YAML="/ide/work/.kitchen.image.yml" bundle exec kitchen verify configs
KITCHEN_YAML="/ide/work/.kitchen.image.yml" bundle exec kitchen destroy configs
```

Here `.kitchen.image.yml` is used.
