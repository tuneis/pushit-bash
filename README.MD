#### A bash script file that allows you to push to your original repo and a backup repo all with one line of code.

### Configure

1. Add .bashrc file.
`
touch ~/.bashrc
`

2. Add alias to .bashrc
`
echo "alias pushit=\"bash C:/scripts/pushit-bash/pushit.sh\"" >> ~/.bashrc
`

### Usage (With alias)
`
pushit repository_path commit_message new_url
`
### Usage (Without alias)
`
bash pushit.sh repository_path commit_message new_url
`

### Example (With alias)
`
pushit ~/code/path_to_repo/ \"Descriptive commit message.\" git@url:port/repository.git
`

### Example (Without alias)
`
bash pushit.sh ~/code/path_to_repo/ \"Descriptive commit message.\" git@url:port/repository.git
`

#### You can do this on Windows through Git Bash. Won't work on command line.

