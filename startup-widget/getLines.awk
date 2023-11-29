{
    line = $0
    while (line ~ / $/) {
        line = substr(line, 1, length(line)-1)
    }
    print line
}
