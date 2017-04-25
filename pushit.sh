# # $1 = path to git config

# while true; do
#     read -p 'Where do you want to push to? (cp/rtag/ask/rcv): ' pushto

#     if [ "$pushto" = "cp" ]
#     then
#         read -p 'Crop Portal. Are you sure? (y/n): ' yn
#         if [ "$yn" = "y" ]
#         then
#             # push to crop portal
#             echo 'Pushing to Crop Portal.'
#         fi
#     fi
# done


# # if [ "$1" = "hi" ]
# # then
# #     echo $1
# # fi
# # echo 'git remote set-url origin git@gitlab.niagararesearch.ca:'"$1"/"$2"
# # echo 'git add .'
# # echo 'git commit -m '"$3"
# # echo 'git push -u origin '"$4" 


# get arguments and store in strongly typed variable names
repository_path=$1
commit_message=$2
new_url=$3
usage="\nUsage: bash pushit.sh repository_path commit_message new_url\n"
example="\nExample: bash pushit.sh ~/code/path_to_repo/ \"Descriptive commit message.\" git@url:port/repository.git\n"

# check if repository path is entered
if [ -z "$repository_path" ]
then
    printf "\nMissing repository path.\n" 
    printf "$usage"
    printf "$example"
    exit 1
elif [ ! -d "$repository_path" ]
then
    printf "\nDirectory does not exist.\n"
    printf "$usage"
    printf "$example"
    exit 1
fi

# check if message is entered
if [ -z "$commit_message" ]
then
    printf "\nMissing commit message.\n"
    printf "$usage"
    printf "$example"
    exit 1
fi

# check if message is entered
if [ -z "$new_url" ]
then
    printf "\nMissing URL.\n"
    printf "$usage"
    printf "$example"
    exit 1
fi

# cd into .git folder and access config file
cd "$repository_path"

# get current branch you are
current_branch=$(git branch | grep \* | cut -d ' ' -f2-)

# check if current branch is empty, means we are on empty repo
# set first branch to master
if [ -z "$current_branch" ]
then
    current_branch="master"
fi

# get url for git repo and removing tabs, line breaks, returns, and space
original_url=$(ls -l | grep "url" "$repository_path/.git/config" | tr -d \\t\\n\\r[:space:])

# remove the first 4 character to get rid of url= so we remain with the actual url for the git repo
original_url=${original_url:4}

# check git status
git status

# show information to user
printf "\nCommit Message: \"$commit_message\""
printf "\nCurrent Branch: $current_branch"
printf "\nOriginal URL: $original_url"
printf "\nNew URL: $new_url"
printf "\nRepository Path: $repository_path\n\n"

# show user what will be added and committed and get confirmation to go ahead
read -p "Is this OK? (y/n): " yn
if [ "$yn" = "y" ]
then
    printf "\nAdding...\n"
    git add .

    printf "\nCommitting...\n\n"
    git commit -m "$commit_message"

    printf "\nPushing... ($original_url)\n\n"
    git push -u origin $current_branch

    printf "\nSetting New URL... ($new_url)\n"
    git remote set-url origin $new_url

    printf "\nPushing... ($new_url)\n\n"
    git push -u origin $current_branch

    printf "\nResetting to Original URL... ($original_url)\n"
    git remote set-url origin $original_url

    printf "\nComplete.\n"
    
else
    echo "\nCancelled... Exiting script."
    exit 1
fi