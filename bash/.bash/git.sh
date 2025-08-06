changelog () {
    git log --no-merges --format="- %s" "$@"
}
