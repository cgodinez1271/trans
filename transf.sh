#!/bin/bash -e
#Mon Dec  8 16:54:45 EST 2014
#Carlos A. Godinez, Principal Engineer
#set -x

[ "$#" -eq 2 ] || { echo "Usage: $0 CT xml-gz-file"; exit; }
CT=$1
FL=$2

if [ ! -d /data02/dcms/instyle/dev/migrate/vignette/$CT ]; then
	echo "Choose: image_component bbproduct gallery lookoftheday tout video package packagehub"
	exit 1
fi

USER=YOURUSER
PASS=YOURPASSWORD

URL=https://dcms-tools.timeinc.net/migrate/instyle/files/$FL

echo -e "\n>>> Tranfering to DEV\n"
rm -f /data02/dcms/instyle/dev/migrate/vignette/$CT/*.xml
cd /data02/dcms/instyle/dev/migrate/vignette/$CT
wget --secure-protocol=TLSv1 --user="$USER" --password="$PASS" $URL -O "${PWD##*/}-$(date +"%Y_%m_%d").xml.gz" && gunzip "${PWD##*/}-$(date +"%Y_%m_%d").xml.gz"

echo -e "\n>>> Tranfering to QA\n"
rm -f /data02/dcms/instyle/qa/migrate/vignette/$CT/*.xml
cd /data02/dcms/instyle/qa/migrate/vignette/$CT
wget --secure-protocol=TLSv1 --user="$USER" --password="$PASS" $URL -O "${PWD##*/}-$(date +"%Y_%m_%d").xml.gz" && gunzip "${PWD##*/}-$(date +"%Y_%m_%d").xml.gz"
 
chgrp -R instyle /data02/dcms/instyle/*/migrate/vignette/$CT
chmod -R 755 /data02/dcms/instyle/*/migrate/vignette/$CT

tree -D /data02/dcms/instyle/dev/migrate/vignette
tree -D /data02/dcms/instyle/qa/migrate/vignette
