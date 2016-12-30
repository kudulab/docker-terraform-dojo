# 0.3.0 (30 Dec 2016)

* terraform 0.8.2 due to conditional values, example: `count = "${var.env == "prod" ? 1 : 0}"`

# 0.2.0 (29 Dec 2016)

* #10293 install openssh-client

# 0.1.1 (30 Nov 2016)

* Terraform 0.7.13, because maybe it fixes https://github.com/hashicorp/terraform/issues/5200
* add inputrc file so that shortcuts like ctrl+left work

# 0.1.0 (17 Sep 2015)

Initial release of docker-terraformide
