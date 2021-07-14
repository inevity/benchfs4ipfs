#!/usr/bin/env bash
# for container 

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat << EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-c, --clean       Container just built
-i, --install   Container just restart
-p, --param     Some param description
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  flag=0
  clean=0
  install=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -f | --flag) flag=1 ;; # example flag
    -c | --clean) clean=1 ;; # to reset deploy
    -i | --install) install=1 ;; # run deploy
    -p | --param) # example named parameter
      param="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
#  [[ -z "${param-}" ]] && die "Missing required parameter: param"
#  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
setup_colors

# script logic here

msg "${RED}Read parameters:${NOFORMAT}"
msg "- flag: ${flag}"
msg "- clean: ${clean}"
msg "- install: ${install}"
msg "- param: ${param}"
msg "- arguments: ${args[*]-}"
#if ${new} eq 1 then

pushd /root/


#tar xvf pkgscontainer.tar.gz
#sh ansibleprepcontainer.sh 172.18.123.49 123456

syncf() {
   rsync -av /root/ipfs/hostsfilecoin /usr/share/ansible-runner-service/project/hosts
   rsync -av /root/ipfs/backend-varsrawdisk.yaml /usr/share/ansible-runner-service/project/files
   rsync -av /root/ipfs/cleanup-varsrawdisk.yaml /usr/share/ansible-runner-service/project/files
}

if [[ $clean -eq 1 ]]; then
   syncf

   echo "-------------------- restrpm,resetrpmperf,resetvolume rawdisk"
   docker container  exec -it runner-service ansible-playbook --tags=resetrpm,resetrpmperf,resetvolume  --extra-vars '{"cleanup_vars":"files/cleanup-varsrawdisk.yaml"}' -i hosts deploy.yml|& tee log0714resetrawdisk
fi




if [[ $install -eq 1 ]]; then
   syncf
   echo "-------------------- install rawdisk"
   docker container  exec -it runner-service ansible-playbook -vv --tags=freshinstall,sethostname,ipconfig,hosts,ntp,perf --extra-vars '{"backend_variables":"files/backend-varsrawdisk.yaml"}' -i hosts deploy.yml|& tee log0714installrawdisk
    

fi

popd
