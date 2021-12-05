### 1.6.0 (2021-Dec-05)

* Install AWS CLI version 2

### 1.5.1 (2021-Aug-16)

* terraform [1.0.4](https://github.com/hashicorp/terraform/blob/v1.0.4/CHANGELOG.md)

### 1.5.0 (2021-May-26)

* use newer base image alpine:3.13
* dojo 0.10.3
* terraform 0.15.4
* terraform-provider-consul 2.12.0
* terraform-provider-openstack 1.42.0
* terraform-provider-aws 3.42.0
* terraform-provider-null 3.1.0
* terraform-provider-external 2.1.0
* terraform-provider-local 2.1.0
* terraform-provider-google 3.69.0 (**added**)
* terraform-provider-template 2.2.0
* terraform-provider-time 0.7.1
* terraform-provider-vault 2.20.0

### 1.4.1 (2020-Oct-25)

* use dojo 0.10.2 docker image scripts, to make it work on Mac using FUSE docker volume driver

### 1.4.0 (2020-Aug-26)
 * upgraded terraform to 0.12.28
 * added assume-role helper tool

### 1.3.0 (2019-Sep-27)
Added make

### 1.2.1 (2019-Sep-15)

 * copy the directory `~/.aws` from docker host to dojo's home

### 1.2.0 (2019-Sep-15)

 * use newer base image alpine:3.10
 * terraform 0.12.8
 * terraform-provider-consul 2.5.0
 * terraform-provider-openstack 1.220
 * terraform-provider-aws 2.28.1
 * terraform-provider-null 2.1.2 1.2.0
 * terraform-provider-external 1.2.0
 * terraform-provider-local 1.3.0
 * terraform-provider-template 2.1.2
 * terraform-provider-vault 2.3.0

### 1.1.0 (2019-May-19)
 * added vault
 * minor fixes in ssh config setup

### 1.0.2 (2019-Apr-24)

 * change source URL to public terraform
 * refactor set_version task
 * added license file

### 1.0.1 (2019-Apr-22)

 * added docker login before push

### 1.0.0 (2019-Apr-21)

 * removed sudo privileges for dojo user
 * remove ait registry and archive references
 * rename to `terraform-dojo`
 * use new releaser and docker-ops (>= 2.0)
 * use github as primary git host
 * dockerhub as main registry, also for the temp image

### 0.8.0 (2019-Apr-15)

 * added AWS plugin

### 0.7.1 (2019-Feb-03)

* newer releaser and docker-ops
* do not use oversion

### 0.7.0 (2019-Feb-03)

* transform from ide docker image to dojo docker image #17139

### 0.6.4 (2018-Nov-29)

* use ide image scripts 0.10.5
* use newer base image alpine:3.8

### 0.6.3 (2018-Nov-26)

* when building docker image, take version from source code (not next_version)

### 0.6.2 (2018-Nov-1)

* in Dockerfile parameterize terraform plugins versions, so that they are not
 repeated 4 times
* terraform 0.11.10
* `TF_PROVIDER_OPENSTACK_VERSION="1.11.0"` #16595 (openstack provider configuration is overridden)
* fix: itests now require less human work

### 0.6.1 (2018-Sep-27) - do not use because of #16595 (openstack provider configuration is overridden)

* install newer terraform-provider-openstack: 1.9.0 #16592
* install newer terraform-provider-consul 2.1.0

### 0.6.0 (2018-Apr-14)

* install jq #12502

### 0.5.1 (2018-Jan-17)

* Terraform 0.11.2

### 0.5.0 (2018-Jan-17)

* no temp docker image, so that we can use docker cache better
* install some terraform plugins, as terraform architecture changed in 0.10.0

### 0.4.3 (2018-Jan-16)

* Terraform 0.10.8 - for salt-masterless provider

### 0.4.2 (2017-Nov-22)

* IDE 0.9.0
* fix this_image_tag environment variable #11928

### 0.4.1 (2017-Jul-04)

* Terraform 0.9.11
* colorful bash prompt
* for development: use releaser and docker-ops, no ruby

# 0.4.0 (20 Feb 2017)

* install curl

# 0.3.0 (30 Dec 2016)

* terraform 0.8.2 due to conditional values, example: `count = "${var.env == "prod" ? 1 : 0}"`

# 0.2.0 (29 Dec 2016)

* #10293 install openssh-client

# 0.1.1 (30 Nov 2016)

* Terraform 0.7.13, because maybe it fixes https://github.com/hashicorp/terraform/issues/5200
* add inputrc file so that shortcuts like ctrl+left work

# 0.1.0 (17 Sep 2015)

Initial release of docker-terraform-dojo
