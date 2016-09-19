FROM terraformide_configs:temp

# Same as at: https://hub.docker.com/r/hashicorp/terraform/~/dockerfile/
ENV TERRAFORM_VERSION=0.7.3
ENV TERRAFORM_SHA256SUM=4e985f222ec99616e8c730d737c9b400f9d73bf0c436661ec888b2406d3a6f39

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
