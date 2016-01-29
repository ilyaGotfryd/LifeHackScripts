
# iterate through a list of folders
for FILE in ./*; do
	if [[ -d $FILE ]]; then
		# eval $FILE
		echo '-----------------------------'
		echo $FILE
		echo '-----------------------------'
		cd $FILE
		git pull
		cd ..
	fi

	done