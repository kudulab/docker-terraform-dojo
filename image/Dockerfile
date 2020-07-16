FROM alpine:3.10

############
# For Dojo:
# * entrypoint requires sudo and shadow
# * git is needed to install dojo image configs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache bash shadow sudo git && \
  git clone --depth 1 -b 0.6.0 https://github.com/kudulab/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git
############

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.12.28
ENV TERRAFORM_SHA256SUM=be99da1439a60942b8d23f63eba1ea05ff42160744116e84f46fc24f1a8011b6

# * font-bitstream-type1 is for graphviz, without it, when generating a png file,
# the text just ends up being a string of boxes
# * openssh-client is needed in infra-ai_stc
# * curl-dev is needed for curl to work
# * curl is needed to get next_version from Consul
RUN apk add --update wget graphviz font-bitstream-type1 openssh-client curl curl-dev make

# pretty bash prompt
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN chown dojo:dojo /home/dojo/.bashrc /home/dojo/.profile

# install jq to parse json in bash
RUN wget --tries=3 --retry-connrefused --wait=3 --random-wait --quiet --show-progress --progress=bar:force https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 &&\
  chmod +x ./jq-linux64 &&\
  mv ./jq-linux64 /usr/bin/jq

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
  wget -O terraform_${TERRAFORM_VERSION}_SHA256SUMS https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS &&\
  cat terraform_${TERRAFORM_VERSION}_SHA256SUMS | grep linux_amd64 > mySHA256SUM.txt &&\
  sha256sum -cs mySHA256SUM.txt &&\
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin &&\
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# install plugins
ENV TF_PROVIDER_CONSUL_VERSION="2.5.0" \
  TF_PROVIDER_OPENSTACK_VERSION="1.22.0" \
  TF_PROVIDER_AWS_VERSION="2.28.1" \
  TF_PROVIDER_NULL_VERSION="2.1.2" \
  TF_PROVIDER_EXTERNAL_VERSION="1.2.0" \
  TF_PROVIDER_LOCAL_VERSION="1.3.0" \
  TF_PROVIDER_TEMPLATE_VERSION="2.1.2" \
  TF_PROVIDER_TIME_VERSION="0.5.0" \
  TF_PROVIDER_VAULT_VERSION="2.3.0"
RUN mkdir -p /home/dojo/.terraform.d/plugins/linux_amd64 && cd /tmp &&\
  wget https://releases.hashicorp.com/terraform-provider-openstack/${TF_PROVIDER_OPENSTACK_VERSION}/terraform-provider-openstack_${TF_PROVIDER_OPENSTACK_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-openstack_${TF_PROVIDER_OPENSTACK_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-openstack_${TF_PROVIDER_OPENSTACK_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-openstack* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  mkdir -p /home/dojo/.terraform.d/plugins/linux_amd64 && cd /tmp &&\
  wget https://releases.hashicorp.com/terraform-provider-aws/${TF_PROVIDER_AWS_VERSION}/terraform-provider-aws_${TF_PROVIDER_AWS_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-aws_${TF_PROVIDER_AWS_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-aws_${TF_PROVIDER_AWS_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-aws* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  mkdir -p /home/dojo/.terraform.d/plugins/linux_amd64 && cd /tmp &&\
  wget https://releases.hashicorp.com/terraform-provider-vault/${TF_PROVIDER_VAULT_VERSION}/terraform-provider-vault_${TF_PROVIDER_VAULT_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-vault_${TF_PROVIDER_VAULT_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-vault_${TF_PROVIDER_VAULT_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-vault* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-null/${TF_PROVIDER_NULL_VERSION}/terraform-provider-null_${TF_PROVIDER_NULL_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-null_${TF_PROVIDER_NULL_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-null_${TF_PROVIDER_NULL_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-null* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-consul/${TF_PROVIDER_CONSUL_VERSION}/terraform-provider-consul_${TF_PROVIDER_CONSUL_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-consul_${TF_PROVIDER_CONSUL_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-consul_${TF_PROVIDER_CONSUL_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-consul* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-external/${TF_PROVIDER_EXTERNAL_VERSION}/terraform-provider-external_${TF_PROVIDER_EXTERNAL_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-external_${TF_PROVIDER_EXTERNAL_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-external_${TF_PROVIDER_EXTERNAL_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-external* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-local/${TF_PROVIDER_LOCAL_VERSION}/terraform-provider-local_${TF_PROVIDER_LOCAL_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-local_${TF_PROVIDER_LOCAL_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-local_${TF_PROVIDER_LOCAL_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-local* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-template/${TF_PROVIDER_TEMPLATE_VERSION}/terraform-provider-template_${TF_PROVIDER_TEMPLATE_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-template_${TF_PROVIDER_TEMPLATE_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-template_${TF_PROVIDER_TEMPLATE_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-template* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-time/${TF_PROVIDER_TIME_VERSION}/terraform-provider-time_${TF_PROVIDER_TIME_VERSION}_linux_amd64.zip &&\
  unzip terraform-provider-time_${TF_PROVIDER_TIME_VERSION}_linux_amd64.zip &&\
  rm terraform-provider-time_${TF_PROVIDER_TIME_VERSION}_linux_amd64.zip &&\
  mv terraform-provider-time_* /home/dojo/.terraform.d/plugins/linux_amd64 &&\

  chown dojo:dojo -R /home/dojo/.terraform.d/
COPY terraformrc /home/dojo/.terraformrc
RUN chown dojo:dojo /home/dojo/.terraformrc

COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/
COPY inputrc /etc/inputrc

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]
