#!/usr/bin/env bash
set -euo pipefail

help(){
  cat <<EOF
usage : $0 [OPTIONS...] [COMMAND]
COMMANDS:
${COMMANDS}

Example:
$0 release --project ae --version 1.1.45
EOF
}

release(){
    if [[ -z "${project}" || -z "${version}" ]]
    then
        echo "project arg (${project}) and version (${version}) are mandatory" >&2
        exit 1
    fi
    check_repo_ready_for_release

    git checkout gh-pages
    git pull
    git merge master --no-edit
    helm package -d "helm/${project}" "${project}"
    helm repo index --url https://helm.gravitee.io/helm helm
    mv helm/index.yaml .
    git add index.yaml
    git add "helm/${project}/${project}-${version}.tgz"
    git commit -m "Publish ${project} chart ${version}"
    git push origin gh-pages
}

check_repo_ready_for_release(){
    if [[ $(git status --porcelain=v2 --untracked-files=no | wc -l) -eq 0 ]]
    then
        return 0
    fi
    return 1
}

### Parse args ###
COMMAND=""
COMMANDS="$(sed -n '/^[a-z].*(){$/ s/(){//p' $0)"
project=""
version=""

while [[ $# -gt 0 ]]
do
    key="$1"
    shift
    case $key in
        --project)
            project="$2"
            shift
        ;;
        --version)
            version="$2"
            shift
        ;;
        -h|--help|help)
            help
            exit 0
        ;;
        *)
            if echo "${COMMANDS}" | grep -q "${key}"
            then
                COMMAND="${key}"
            else
                echo "unknown arg : ${key}" >&2
                exit 1
            fi
        ;;
    esac
done

### main ###
if [[ -z "${COMMAND}" ]]
then
    help
    exit 0
fi

"${COMMAND}"

