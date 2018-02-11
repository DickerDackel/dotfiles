invoice () {
    amount=$1; shift 1
    rate=$1; shift 1
    echo "3k $amount $rate * p d 0.19 * p + p" | dc
}
