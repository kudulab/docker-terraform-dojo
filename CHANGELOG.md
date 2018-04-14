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

Initial release of docker-terraformide
