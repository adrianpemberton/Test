#!/bin/bash
filesChanged=$(git diff-tree --no-commit-id --name-only -r $lastCommit)
if [ ${#filesChanged[@]} -eq 0 ]; then
    echo "No files to update"
else
    for f in $filesChanged
	do
		#do not upload these files that aren't necessary to the site
		if [ "$f" != ".travis.yml" ] && [ "$f" != "deploy.sh" ]
		then
	 		echo "Uploading $f"
      curl --ftp-create-dirs -T index.html -u $FTP_USER:$FTP_PASSWORD ftp://travis.alfutures.co.uk
		fi
	done
fi
