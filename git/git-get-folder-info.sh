# Check if a directory was provided
if [ -z "$1" ]; then
    echo "❌ Please provide a directory path"
    echo "Usage: ./git-get-folder-info.sh /path/to/repo"
    exit 1
fi

# Check if directory exists
if [ ! -d "$1" ]; then
    echo "❌ Directory does not exist: $1"
    exit 1
fi

# Change to the specified directory
cd "$1" || exit 1

# Check if it's a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not a git repository: $1"
    exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 Repository: $1"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

echo "🌐 REMOTE INFORMATION:"
echo "----------------------"
if ! git remote show origin 2>/dev/null; then
    echo "❌ No remote configured"
fi
echo

echo "📊 STATUS:"
echo "---------"
git status
echo

echo "🌿 BRANCHES:"
echo "-----------"
echo "Current branch: $(git branch --show-current)"
echo "All branches:"
git --no-pager branch -a
echo
echo "════════════════════════════════════════════"