#!/bin bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WP_PATH=$(dirname "${SCRIPT_PATH}")

# Define the directory containing your .env files
ENV_DIR="./env"

# Function to read and apply environment variables from a file
apply_env() {
    local env_file=$1
    echo "Processing $env_file"

    # Use a temporary file to store the effective environment variables
    local tmp_env=$(mktemp)

    # Ensure default values are loaded first if default.env exists
    if [ -f "$ENV_DIR/default.env" ]; then
        cat "$ENV_DIR/default.env" >"$tmp_env"
    fi

    # Then append site-specific variables, which allows them to override defaults
    cat "$env_file" >>"$tmp_env"

    # Process the compiled environment variables
    while IFS='=' read -r key value || [[ -n "$key" ]]; do
        # Skip lines starting with #, empty lines, and lines not containing an equals sign
        [[ $key = \#* || $key = "" || ! $key == *\=* ]] && continue

        # Here you would apply or use each environment variable as needed
        # For demonstration, we're just printing them out
        echo "$key=$value"
    done <"$tmp_env"

    # Clean up the temporary file
    rm "$tmp_env"
}

# Main function
main() {
    # Loop through the .env files in the specified directory, excluding default.env
    for env_file in "$ENV_DIR"/*.local.env; do
        if [ -f "$env_file" ]; then
            apply_env "$env_file"
        fi
    done
}

# Execute main function
main

exit 0
