# get all migration scripts

APPRENTICE_FOLDERS=()

# get all apprentice folders
for FILE in ./*; do
	if [[ -d $FILE ]]; then
		APPRENTICE_FOLDERS+=("$FILE")
		# echo ${#APPRENTICE_FOLDERS[@]} 
		# echo $APPRENTICE_FOLDERS
	fi
done

# echo $APPRENTICE_FOLDERS
echo '----------------'
for FOLDER in "${APPRENTICE_FOLDERS[@]}"
do
	# echo {$APPRENTICE_FOLDERS[$i]}
	echo '--------------------------------'
	echo $FOLDER
	echo '--------------------------------'
	for SQL_FILE in `find ./"$FOLDER" -type f -name "*.sql"`
	do
		if grep -qi "CREATE TABLE" "$SQL_FILE"; then
			echo $SQL_FILE
		fi
	done
	# for SQL_FILE in find ./"$FOLDER" 
	# if grep -q "CREATE TABLE" 

done