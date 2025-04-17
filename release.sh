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

    echo "Release ${project} to ${version}:"
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
    echo "Release Done ✔ "
}

check_repo_ready_for_release(){
    if [[ $(git status --porcelain=v2 --untracked-files=no | wc -l) -eq 0 ]]
    then
        return 0
    fi
    echo "Your git repo is not clean - please cleanup before release." >&2
    return 1
}

### Parse args ###
COMMAND="help"
COMMANDS="$(sed -n '/^[a-z].*(){$/ s/(){//p' $0)"
project=""
version=""

# === Argument Parser ===
while [[ $# -gt 0 ]]; do
    case "$1" in
        --project) project="$2"; shift 2;;
        --version) version="$2"; shift 2;;
        -h|--help|help) COMMAND="help"; shift; break;;
        *)
          if echo "${1}" | grep -q "${COMMANDS}"
          then
            COMMAND="${1}"
          else
            echo "unknown arg : ${1}" >&2
            exit 1
          fi
          shift
        ;;
    esac
done

### main ###
"${COMMAND}"

