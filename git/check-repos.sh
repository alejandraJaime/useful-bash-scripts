search_dir="${1:-$HOME}"  # Use provided path or default to HOME
echo "🔎 Searching for git repositories in: $search_dir"

find "$search_dir" -type d -name ".git" 2>/dev/null | while read -r repo; do
    echo "$(dirname "$repo")"
done