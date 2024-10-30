hp() {
    out=$(sh -c "bhop ${1} ${2} ${3} ${4}")
    if [[ "$out" != *"|"* ]]; then
        echo $out
        return
    fi
    IFS="|" read -ra arr <<< "$out"
    cd ${arr[0]}
    sh -c "${arr[1]}"
}

