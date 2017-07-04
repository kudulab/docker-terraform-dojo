FROM terraformide_configs:temp

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.9.11
ENV TERRAFORM_SHA256SUM=804d31cfa5fee5c2b1bff7816b64f0e26b1d766ac347c67091adccc2626e16f3

# * font-bitstream-type1 is for graphviz, without it, when generating a png file,
# the text just ends up being a string of boxes
# * openssh-client is needed in infra-ai_stc
# * curl-dev is needed for curl to work
# * curl is needed to get next_version from Consul
RUN apk add --update wget graphviz font-bitstream-type1 openssh-client curl curl-dev

# faster way than official public:
ADD http://http.archive.ai-traders.com/chefdev/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
