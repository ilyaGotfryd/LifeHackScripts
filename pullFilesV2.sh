gitUser=$1
repoName=$2
revision=$3
projPath=$4
echo https://api.bitbucket.org/1.0/repositories/${gitUser}/${repoName}/src/${revision}/${projPath}
for filePath in $( curl -X GET https://api.bitbucket.org/1.0/repositories/${gitUser}/${repoName}/src/${revision}/${projPath} | jq '.files[].path' ); do
# remove leading and trailing quote    
    cleanPath=${filePath#"\""}
    cleanPath=${cleanPath%"\""}
    echo found path: $cleanPath
#extract filenames from the git path    
    filename="${cleanPath##*/}"
    echo file name: $filename 
#pull individual file via API
#extract data from JSON via jq
#clean first and last single quote, replace \n with new line and replace \" with "
#then write to file
    curl -X GET https://api.bitbucket.org/1.0/repositories/${gitUser}/${repoName}/src/${revision}/${cleanPath} | jq '.data' | awk '{print substr($0, 2, length($0) - 2)}' | awk '{gsub(/\\n/,"\n")}1'| awk '{gsub(/\\"/,"\"")}1' >$filename
done
#the script works well for text files but fails for images and other binary.