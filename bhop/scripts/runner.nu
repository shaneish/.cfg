def-env hp [cmd: string, p1: string = "", p2: string = "", p3: string = ""] {
    let command = (nu -c ($"bhop ($cmd) ($p1) ($p2) ($p3)" | str trim))
    if ($command | str contains "|" --not) {
        echo $command
        return
    }
    let arr = ($command | split column "|" to_move to_exec)
    cd ($arr.to_move | get 0)
    nu -c $"($arr.to_exec | get 0)"
}

