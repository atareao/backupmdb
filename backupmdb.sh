#!/bin/bash
pcds=/var/opt/mariadb
cds=$pcds/copia_de_seguridad_$(date +%Y%m%dT%H.%M.%S).sql
mysqldump --all-databases --lock-tables > $cds
if [ $? -eq 0 ]
then
    gzip $cds
    limite=$(date +%Y%m%dT%H.%M.%S -d "-7 days")
    for i in $pcds/*.sql.gz
        do
        if [[ ${i:36:17} < $limite ]] && [[ -e $i ]]
        then
            rm $i
        fi
    done
else
    if [[ -e $cds ]]
    then
        rm $cds
    fi
    source /root/.telegram_keys
    URL=https://api.telegram.org/bot$TOKEN/sendMessage
    message="No se ha podido hacer la copia de seguridad"
    curl -s -X POST $URL -d chat_id=$CHANNEL -d text="$message" >/dev/null 2>&1
fi
