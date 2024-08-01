# This scripts aims to facilitate the process of git clone / git pull repositories
# depending if they already exists of not

# Read the file line by line
while IFS=, read -r repo path; do
    # Ignore lines that are comments or empty
    if [[ "$repo" =~ ^#.* ]] || [[ -z "$repo" ]]; then
        continue
    fi

    # Trim any leading/trailing whitespace from the path
    path=$(echo "$path" | xargs)

    # Check if the directory already exists
    if [ -d "$path/.git" ]; then
        # If the directory exists, perform a git pull
        echo "Directory $path exists. Pulling latest changes."
        git -C "$path" pull
    else
        # If the directory doesn't exist, clone the repository
        echo "Cloning $repo into $path."
        git clone "$repo" "$path"
    fi
done < /opt/my-resources/setup/git/repos.list