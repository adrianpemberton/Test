#!/bin/bash
filesChanged=$(git diff)
if [ ${#filesChanged[@]} -eq 0 ]; then
    echo "No files to update"
else
    for f in $filesChanged
	do
		#do not upload these files that aren't necessary to the site
		if [ "$f" != ".travis.yml" ] && [ "$f" != "deploy.sh" ]
		then
	 		echo "Uploading $f"
	 		curl --ftp-create-dirs -T $f -u $FTP_USER:$FTP_PASSWORD ftp://travis.alfutures.co.uk/$f
		fi
	done
fi
