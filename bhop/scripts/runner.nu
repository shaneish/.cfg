def-env hp [cmd: string, p1: string = "", p2: string = "", p3: string = ""] {
    let command_str = $"bhop $cmd $p1 $p2 $p3"
    let command = nu -c $command_str
    if $command | str contains "|" --not {
        echo $command
        return
    }
    let arr = $command | split column "|" to_move to_exec
    let dir = $arr.to_move | get 0
    cd $dir
    let cmd = $arr.to_exec | get 0
    nu -c $cmd
}

