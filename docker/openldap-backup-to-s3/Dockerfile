# Use mbasri/openldap
# sources: https://github.com/mbasri/openldap
FROM garland/aws-cli-docker:1.16.140
LABEL MAINTAINER="Mohamed BASRI <mbasri@outlook.fr>"

RUN apk add bash

COPY files/backup-to-s3.sh /backup-to-s3.sh

ENV BUCKET_NAME="MY_BUCKET_NAME"

CMD ["bash", "-c", "/backup-to-s3.sh"]