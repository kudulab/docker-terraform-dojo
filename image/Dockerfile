# We could start FROM hashicorp/packer:light,
# https://hub.docker.com/r/hashicorp/packer/tags/
# but we want to lock Packer version.
FROM alpine:3.5

############
# For ide:
# * entrypoint requires sudo and shadow
# * git is needed to install ide image configs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache bash shadow sudo git && \
  git clone --depth 1 -b 0.9.0 https://github.com/ai-traders/ide.git /tmp/ide_git && \
  /tmp/ide_git/ide_image_scripts/src/install.sh && \
  rm -r /tmp/ide_git && \
  echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
############

COPY etc_ide.d/scripts/* /etc/ide.d/scripts/
COPY inputrc /etc/inputrc

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.11.2
ENV TERRAFORM_SHA256SUM=f728fa73ff2a4c4235a28de4019802531758c7c090b6ca4c024d48063ab8537b

# * font-bitstream-type1 is for graphviz, without it, when generating a png file,
# the text just ends up being a string of boxes
# * openssh-client is needed in infra-ai_stc
# * curl-dev is needed for curl to work
# * curl is needed to get next_version from Consul
RUN apk add --update wget graphviz font-bitstream-type1 openssh-client curl curl-dev

# pretty bash prompt
COPY bashrc /home/ide/.bashrc
RUN chown ide:ide /home/ide/.bashrc

# install jq to parse json in bash
RUN export wget_options="--tries=3 --retry-connrefused --wait=3 --random-wait --quiet --show-progress --progress=bar:force" &&\
  bash -c "\
    wget ${wget_options} http://http.archive.ai-traders.com/jq/v1.5/jq-linux64 ||\
    wget ${wget_options} https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64" &&\
  chmod +x ./jq-linux64 &&\
  mv ./jq-linux64 /usr/bin/jq

# faster way than official public:
ADD http://http.archive.ai-traders.com/chefdev/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# install plugins
RUN mkdir -p /home/ide/.terraform.d/plugins/linux_amd64 && cd /tmp &&\
  wget https://releases.hashicorp.com/terraform-provider-openstack/1.9.0/terraform-provider-openstack_1.9.0_linux_amd64.zip &&\
  unzip terraform-provider-openstack_1.9.0_linux_amd64.zip &&\
  rm terraform-provider-openstack_1.9.0_linux_amd64.zip &&\
  mv terraform-provider-openstack* /home/ide/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-null/1.0.0/terraform-provider-null_1.0.0_linux_amd64.zip &&\
  unzip terraform-provider-null_1.0.0_linux_amd64.zip &&\
  rm terraform-provider-null_1.0.0_linux_amd64.zip &&\
  mv terraform-provider-null* /home/ide/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-consul/1.0.0/terraform-provider-consul_1.0.0_linux_amd64.zip &&\
  unzip terraform-provider-consul_1.0.0_linux_amd64.zip &&\
  rm terraform-provider-consul_1.0.0_linux_amd64.zip &&\
  mv terraform-provider-consul* /home/ide/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-external/1.0.0/terraform-provider-external_1.0.0_linux_amd64.zip &&\
  unzip terraform-provider-external_1.0.0_linux_amd64.zip &&\
  rm terraform-provider-external_1.0.0_linux_amd64.zip &&\
  mv terraform-provider-external* /home/ide/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-local/1.1.0/terraform-provider-local_1.1.0_linux_amd64.zip &&\
  unzip terraform-provider-local_1.1.0_linux_amd64.zip &&\
  rm terraform-provider-local_1.1.0_linux_amd64.zip &&\
  mv terraform-provider-local* /home/ide/.terraform.d/plugins/linux_amd64 &&\

  wget https://releases.hashicorp.com/terraform-provider-template/1.0.0/terraform-provider-template_1.0.0_linux_amd64.zip &&\
  unzip terraform-provider-template_1.0.0_linux_amd64.zip &&\
  rm terraform-provider-template_1.0.0_linux_amd64.zip &&\
  mv terraform-provider-template* /home/ide/.terraform.d/plugins/linux_amd64 &&\

  chown ide:ide -R /home/ide/.terraform.d/
COPY terraformrc /home/ide/.terraformrc
RUN chown ide:ide /home/ide/.terraformrc


ARG this_image_tag_arg
ARG this_image_name_arg
ENV this_image_tag=${this_image_tag_arg} this_image_name=${this_image_name_arg}
