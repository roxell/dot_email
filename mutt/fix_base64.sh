#!/bin/bash

[[ -d $1 ]] && base_path=$1 || { echo "No base path given as argument, exiting"; exit 1; }

for mail in $base_path/*.mbox; do
	grep '^Content-Transfer-Encoding: base64' $mail >/dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		cat $mail |sed -n '/^$/,$p; /^$/d' |base64 -d > ${mail}.body 2>/dev/null
		if [[ $? -eq 0 ]]; then
			cat $mail | sed -n '1,/^$/p;' > ${mail}.headers
			sed -i '/^Content-T.*base64/d' ${mail}.headers
			cat ${mail}.headers > $mail
			cat ${mail}.body >> $mail
			rm ${mail}.headers
		fi
		rm ${mail}.body
	fi
done
