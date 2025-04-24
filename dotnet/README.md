# Hooks usage

```sh
dvd() {
    local tt="$1"
    local hooks=()
    local ph=false

    for arg in "$@"; do
        if [ "$arg" = "--hooks" ]; then
           ph=true
        elif [ "$ph" = true ]; then
            hooks+=("$arg")
        elif [ -z "$tt" ]; then
            tt="$arg"
        fi
    done

    if [ -z "$tt" ]; then
        echo "Error: No template type specified"
        echo "Usage: dvd <template-type> [--hooks hook1 hook2]"
        return 1
    fi

    echo "use flake \"github:hangtaip/dev-templates?dir=$tt\"" > .envrc
    direnv allow

    for hook in "${hooks[@]}"; do
        echo "# Applying $hook hook"
        local hurl="https://raw.githubusercontent.com/hangtaip/dev-templates/main/$tt/$hook-hooks.sh"

        curl -s --fail "https://raw.githubusercontent.com/hangtaip/dev-templates/main/$tt/$hook-hooks.sh" > "$hs"

        if curl -s --head "$hurl" | grep -q "200 OK"; then
            echo "# Content from $hook-hooks.sh" >> .envrc
            curl -s "$hurl" >> .envrc
            echo "" >> .envrc
        else
            echo "Warning: Hook script '$hook-hooks.sh' for template $tt not found"
        fi

    done

    direnv allow
}

dvd <template_type> [--hooks hook1 hook2]
```
