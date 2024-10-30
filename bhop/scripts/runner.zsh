hp() {
    out=$(zsh -c "bhop ${1} ${2} ${3} ${4}")
    if [[ "$out" != *"|"* ]]; then
        echo $out
        return
    fi
    export arr=(${(@s:|:)out})
    cd ${arr[1]}
    zsh -c "${arr[2]}"
}

