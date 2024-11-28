search_dir="${1:-$HOME}"
echo "🔎 Searching for git repositories in: $search_dir"
echo "-------------------"
echo


find "$search_dir" -type d -name ".git" 2>/dev/null | while read -r repo; do
    repo_path=$(dirname "$repo")
    cd "$repo_path" || continue
    
    remote_url=$(git config --get remote.origin.url)
    
    #echo "$repo_path"
    if [ -n "$remote_url" ]; then
        echo "📂Local Folder: $repo_path"
        echo "🌐 Remote: $remote_url"
    else
        echo "📂Local Folder: $repo_path"
        echo "❌ No remote configured"
    fi
    echo "-------------------"
    echo
done