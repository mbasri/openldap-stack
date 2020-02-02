#!/bin/bash -x

for i in `find /backup -type f -name "*-*.gz" ! -size 0 | sort -nr`
do
  YEAR=`echo ${i} | sed -e 's/.*\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\).*/\1/g'`
  MONTH=`echo ${i} | sed -e 's/.*\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\).*/\2/g'`
  DAY=`echo ${i} | sed -e 's/.*\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\).*/\3/g'`

  aws s3 cp ${i} s3://${BUCKET_NAME}/year=${YEAR}/month=${MONTH}/day=${DAY}/
  if [ "$?" -ne "0" ]; then echo "S3 Push failed"; exit 1; fi

  rm -f ${i}
done
exit 0
