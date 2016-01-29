for filePath in $( curl -X GET https://api.bitbucket.org/1.0/repositories/hstocker/swcguild/src/9bfb46d122c141c9825951286fd8443cb7f713a0/Pre-work/HTML/albumv2/ | jq '.files[].path' ); do
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
    curl -X GET https://api.bitbucket.org/1.0/repositories/hstocker/swcguild/src/9bfb46d122c141c9825951286fd8443cb7f713a0/${cleanPath} | jq '.data' | awk '{print substr($0, 2, length($0) - 2)}' | awk '{gsub(/\\n/,"\n")}1'| awk '{gsub(/\\"/,"\"")}1' >$filename
done
#the script works well for text files but fails for images and other binary.