# Cleaned up cat, stipped of comments/empty lines.  Good for reading the
# actual settings in humongous config file templates

clat () {
    cat "$@" | perl -lane '/\S/ && ! /^\s*#/ && print'
}
