#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
venv_dir="${script_dir}/.venv"

if [[ ! -d "${venv_dir}" ]]; then
  python3 -m venv "${venv_dir}"
fi

# shellcheck disable=SC1091
source "${venv_dir}/bin/activate"

python -m pip install --upgrade pip
python -m pip install -r "${repo_root}/requirements.txt"

export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i "${script_dir}/inventory.ini" -b "${repo_root}/cluster.yml"