# We could start FROM hashicorp/packer:light,
# https://hub.docker.com/r/hashicorp/packer/tags/
# but we want to lock Packer version.
FROM alpine:3.8

############
# For Dojo:
# * entrypoint requires sudo and shadow
# * git is needed to install ide image configs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache bash shadow sudo git && \
  git clone --depth 1 -b 0.2.1 https://github.com/ai-traders/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git && \
  echo 'dojo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
############

COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/
COPY inputrc /etc/inputrc

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.11.10
ENV TERRAFORM_SHA256SUM=43543a0e56e31b0952ea3623521917e060f2718ab06fe2b2d506cfaa14d54527

# * font-bitstream-type1 is for graphviz, without it, when generating a png file,
# the text just ends up being a string of boxes
# * openssh-client is needed in infra-ai_stc
# * curl-dev is needed for curl to work
# * curl is needed to get next_version from Consul
RUN apk add --update wget graphviz font-bitstream-type1 openssh-client curl curl-dev

# pretty bash prompt
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN chown dojo:dojo /home/dojo/.bashrc /home/dojo/.profile

# install jq to parse json in bash
RUN export wget_options="--tries=3 --retry-connrefused --wait=3 --random-wait --quiet --show-progress --progress=bar:force" &&\
  bash -c "\
    wget ${wget_options} http://http.archive.ai-traders.com/jq/v1.5/jq-linux64 ||\
    wget ${wget_options} https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64" &&\
  chmod +x ./jq-linux64 &&\
  mv ./jq-linux64 /usr/bin/jq

# download from private endpoint to make it faster than from public endpoint:
RUN wget http://http.archive.ai-traders.com/chefdev/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
  wget -O terraform_${TERRAFORM_VERSION}_SHA256SUMS https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS &&\
  cat terraform_${TERRAFORM_VERSION}_SHA256SUMS | grep linux_amd64 > mySHA256SUM.txt &&\
  sha256sum -cs mySHA256SUM.txt &&\
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin &&\
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# install plugins
ENV TF_PROVIDER_CONSUL_VERSION="2.1.0" \
  TF_PROVIDER_OPENSTACK_VERSION="1.11.0" \
  TF_PROVIDER_AWS_VERSION="2.6.0" \
  TF_PROVIDER_NULL_VERSION="1.0.0" \
  TF_PROVIDER_EXTERNAL_VERSION="1.0.0" \
  TF_PROVIDER_LOCAL_VERSION="1.1.0" \
  TF_PROVIDER_TEMPLATE_VERSION="1.0.0"
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

  chown dojo:dojo -R /home/dojo/.terraform.d/
COPY terraformrc /home/dojo/.terraformrc
RUN chown dojo:dojo /home/dojo/.terraformrc
