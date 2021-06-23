# 1. Make sure that you have permission to run the file:
#     1. Change mode, execute, myscript.sh
#         1. chmod +x myscript.sh
# 2. Check where Bash is: 
#     1. which bash
#         1. For me, usr/local/bin/bash
# 3. (To tell the script where to look for bash, use a shebang)
#     1. #! usr/local/bin/bash

#! /usr/local/bin/bash

# To see the command flags you can use:
# curl --help OR curl --manual

# ECHO COMMAND 
# echo Hello World!

# VARIABLES
# Uppercase by convention
# What's allowed in variables? Letters, numbers and underscores
# NAME="Hazel"
# echo "My name is $NAME"

# USER INPUT
# read -p "Enter your name: " FIRST_NAME
# echo "Hello $FIRST_NAME, nice to meet you!"

# SIMPLE IF STATEMENT
# if [ "$NAME" == "Will" ]
# then
#     echo "Your name is Will"
# fi

# IF/ELSE
# if [ "$NAME" == "Will" ]
# then
#     echo "Your name is Will"
# else
#     echo "Your name is NOT Will"
# fi

# ELSE_IF (elif)
# if [ "$NAME" == "Will" ]
# then
#     echo "Your name is Will"
# elif [ "$NAME" == "Hazel" ]
# then
#     echo "Your name is Hazel"
# else
#     echo "Your name is NOT Will or Hazel"
# fi

########
# COMPARISON
# val1 -eq val2 # Returns true if the values are equal 
# val1 -ne val2 # Returns true if the values are not equal
# val1 -gt val2 # Returns true if the val1 is greater than val2
# val1 -ge val2 # Returns true if val1 is greater than or equal to val2
# val1 -lt val2 # Returns true if val1 is less than val2 
# val1 -le val2 # Returns true if val1 is less than or equal to val2

# NUM1=31
# NUM2=5
# if [ "$NUM1" -gt "$NUM2" ] 
# then 
#     echo "$NUM1 is greater than $NUM2"
# else 
#     echo "$NUM1 is less than $NUM2"
# fi
########

########
# FILE CONDITIONS

# FILE="text.txt"
# if [ -f "$FILE" ] # Note: -f checks if a 
# then 
#     echo "$FILE is a file"
# else
#     echo "$FILE is not a file"
# fi

# -d file   True if the file is a directory
# -e file   True if the file exists (note that this is not particularly portable, thus -f is generally used)
# -f file   True if the provided string is a file
# -g file   True if the group id is set on a file
# -r file   True if the file is readable
# -s file   True if the file has a non-zero size
# -u    True if the user id is set on a file
# -w    True if the file is writable
# -x    True if the file is an executable
########

########
# COMMAND LINE SHORTCUTS
# touch test.txt # Create a file 
# mkdir Example # Creates a folder (directory) 
# rm text.txt # Deletes the file
########

########
# CASE STATEMENT
# read -p "Are you 21 or over? Y/N" ANSWER
# case "$ANSWER" in
#     [yY] | [yY][eE][sS]) # Note: 'or' is | (similar to JS) and you need to end the check with a parenthesis
#         echo "You can have a beer :)"
#         ;;  # Note: You need to end the case with double 
#     [nN] | [nN][oO])
#         echo "Sorry, you can't legally drink"
#         ;;
#     *)
#         echo "Please enter a y/yes or n/no"
#         ;;
########

# SIMPLE FOR LOOP
# NAMES="Will Kevin Alice Mark"
# for NAME in $NAMES
#     do 
#         echo "Hello $NAME"
# done
########

########
# FOR LOOP TO RENAME FILES 
# FILES=$(ls *.txt)
# NEW="new"
# for FILE in $FILES
#     do 
#         echo "Renaming $FILE to new-$FILE"
#         mv $FILE $NEW-$FILE # Note: the mv command us usually used for moving files
# done
########

########
# WHILE LOOP - READ THROUGH A FILE LINE BY LINE 
# LINE=1
# while read -r CURRENT_LINE
#     do 
#         echo "$LINE: $CURRENT_LINE"
#         ((LINE++))
# done < "./new-1.txt"
########

########
# FUNCTION 
# function sayHello() {
#     echo "Hello World!"
# }
# sayHello
########

########
# FUNCTION WITH PARAMS - Note: you don't pass in params as you would with JS. Bash uses "positional" params
# function greet() {
#     echo "Hello, I am $1 and I am $2"
# }
# greet "Will" "31"
########

########
# CREATE A FOLDER AND WRITE TO A FILE 
# mkdir hello
# touch "hello/world.txt"
# echo "Hello World" >> "hello/world.txt" # Note: to write to the actual file you've just created, you need to include the text you want to add and then use ">>" to access the file you want to write to
# echo "Created hello/world.txt"
########

########
# SEND A POST REQUEST
# curl -0 -v POST http://conductor-server:8080/api/event \ # Note: -0 is telling the script to use HTTP 1.0 and -v is 'verbose' or 'Make the operation more talkative'
# -H "Expect:" \ # Note: -H is the header - Pass custom header(s) to the server 
# -H 'Content-Type: application/json; charset=utf-8' \ # Note: Telling the server that the content is JSON
# -d @- <<'EOF' # Note: -d is HTTP POST data, using @- will make curl read the header file from stdin and the '<< EOF' simply tells the script to stop when it 'reads' EOF

# {
#   "name": "complete_task",
#   "event": "kafka:complete-task",
#   "condition": true,
#   "actions": [
#     {
#       "action": "complete_task",
#       "complete_task": {
#         "workflowId": "${workflowId}",
#         "taskRefName": "${taskRefName}",
#         "output": {
#           "message": "${message}"
#         }
#       }
#     }
#   ],
#   "active": true
# }
# EOF
########

########
# UPDATE A USER IN ROUTIFIC DATABASE
# sleep 2

# curl -0 -v POST http://localhost:3006/user/create \
# -H "Expect:" \
# -H 'Content-Type: application/json; charset=utf-8' \
# -d @- <<'EOF'

# {
#     "fullname": "First User",
#     "email": "fake@routific.com",
#     "password": "password",
#     "organization": "Routific"
# }
# EOF

# sleep 2

# # If psql is not available, then exit
# if ! command -v psql > /dev/null; then
#   echo "This script requires psql to be installed and on your PATH ..."
#   exit 1
# fi

# PGPASSWORD="postgres" psql -t -A \ # Note: The forward slash (\) is telling bash that this command still has more to come
# -h "localhost" \
# -p "5433" \
# -U "postgres" \
# -c "\c routific_planning" \
# -c "update users_roles set role_id = 2 where user_id = 1;"
########

########
# USING jq (JSON PARSER) TO ACCESS VALUES WITHIN A REST API RESPONSE
# https://askubuntu.com/questions/678915/whats-the-difference-between-and-in-bash
# sleep 1

# RESPONSE=`curl -0 -v POST http://localhost:3006/user/create \
# -H "Expect:" \
# -H 'Content-Type: application/json; charset=utf-8' \
# -d @- <<'EOF'

# {
#     "fullname": "s",
#     "email": "trump2@routific.com",
#     "password": "password",
#     "organization":{
#       "name": "trump2"
#     }
# }
# EOF
# ` 

# sleep 1

# echo look here $RESPONSE

# ID=$(jq -r '.id' <<< $RESPONSE) # Note: 

# echo $ID
########

# List all ports in use: sudo lsof -i -n -P | grep TCP
