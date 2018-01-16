FROM docker-registry.ai-traders.com/terraformide:temp

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.10.8
ENV TERRAFORM_SHA256SUM=b786c0cf936e24145fad632efd0fe48c831558cc9e43c071fffd93f35e3150db

# * font-bitstream-type1 is for graphviz, without it, when generating a png file,
# the text just ends up being a string of boxes
# * openssh-client is needed in infra-ai_stc
# * curl-dev is needed for curl to work
# * curl is needed to get next_version from Consul
RUN apk add --update wget graphviz font-bitstream-type1 openssh-client curl curl-dev

# pretty bash prompt
COPY bashrc /home/ide/.bashrc
RUN chown ide:ide /home/ide/.bashrc

# faster way than official public:
ADD http://http.archive.ai-traders.com/chefdev/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
