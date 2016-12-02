FROM terraformide_configs:temp

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.7.13
ENV TERRAFORM_SHA256SUM=5a4f762a194542d38406b9b92c722b57f7910344db084e24c9c43d7719f4aa18

# font-bitstream-type1 is for graphviz, without it, when generating a png file,
# the text just ends up being a string of boxes
RUN apk add --update wget graphviz font-bitstream-type1

# faster way than official public:
ADD http://http.archive.ai-traders.com/chefdev/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
