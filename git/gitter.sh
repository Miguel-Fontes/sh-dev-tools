#!/bin/bash

# Gitter - The Git utility belt.

source ~/shell-tools/utils/environment.sh

declare -r USAGE="
USAGE: $(basename "$0") [OPTIONS]
       $(basename "$0") --stage
       $(basename "$0") --stage --exclude /target/
       $(basename "$0") -s -e my-source-file.java my-resource.properties

Available options:
    -s, --stage     Stage all changed files, or a subset of those filtered by a pattern provided by the --exclude option.
    -e, --exclude   Excludes files from operations. This filter is made using a regex expression with grep. Adittionaly,
                    any number of exclusion can be defined: they will be combine with an OR ( PATTERN | PATTERN | PATTERN ).
    -h, --help      Prints this help message.
"

# Verify dependencies
validateCommands "git"
if [[ ${?} -ne 0 ]]; then
    echo "ERROR: Required dependencies are not available. Please, review your execution environment and try again!"
    exit 1
fi

help() {
    echo "$USAGE"
}

getChangedFilesList() {
    echo "$(git status -s | cut -c 4- | awk -F ' ' '{print $NF}')"
}

stageFiles() {
    local CHANGED_FILES="$(getChangedFilesList)"

    if [[ "$EXCLUDES" == 'true' ]]; then
        FILES_TO_STAGE="$(echo "$CHANGED_FILES" | grep -v -E "($(echo $FILES_TO_EXCLUDE | paste -s -d '|'))" | paste -s -d ' ')"
    else 
        FILES_TO_STAGE=$CHANGED_FILES
    fi

    git stage $FILES_TO_STAGE
}

# Prints a help message if no argument was given
test "${#}" -eq 0 && (help && exit 0)

while [[ -n "$1" ]]; do
    case "$1" in
    -s | --stage)
        STAGE='true'
        ;;
    -e | --exclude)
        EXCLUDES='true'
        FILES_TO_EXCLUDE+="$2 "
        shift
        ;;
    -h | --help)
        help
        exit 0
        ;;
    esac

    shift
done

test "$STAGE" == 'true' && stageFiles
