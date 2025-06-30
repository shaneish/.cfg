function l -d "faster list"
    if type -q "eza"
        eza $argv[1..]
    else if type -q "lsd"
        lsd $argv[1..]
    else
        ls $argv[1..]
    end
end
