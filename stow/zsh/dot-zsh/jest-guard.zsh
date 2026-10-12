# jest guard: block running jest with no file/pattern (full suite / watch pegs the machine)
__jest_has_target() {
  local -a value_opts=(
    -c --config -t --testNamePattern --testPathPattern
    --testPathIgnorePatterns --testMatch --testRegex --roots
    --reporters --moduleNameMapper --transform --maxWorkers -w
    --selectProjects --outputFile --coverageDirectory --globals
    --modulePathIgnorePatterns --testEnvironment --testRunner
  )
  local arg skip=0
  for arg in "$@"; do
    if (( skip )); then skip=0; continue; fi
    case "$arg" in
      --) return 0 ;;
      --*=*|-*=*) continue ;;
      -*)
        (( ${value_opts[(Ie)$arg]} )) && skip=1
        continue ;;
      *) return 0 ;;
    esac
  done
  return 1
}

__jest_guard() {
  local label="$1"
  shift
  __jest_has_target "$@" && return 0
  print -u2 ""
  print -u2 "  jest bloqueado: sem alvo roda a suite inteira/watch e derruba a maquina."
  print -u2 "  passe um arquivo ou padrao, ex.: $label path/to/file.test.ts"
  print -u2 ""
  return 1
}

__jest_wrap() {
  local pm="$1"
  shift
  local -a rest
  if [[ "$1" == jest ]]; then
    rest=("${@[2,-1]}")
    __jest_guard "$pm jest" "${rest[@]}" || return 1
  elif [[ ( "$pm" == pnpm || "$pm" == yarn ) && ( "$1" == exec || "$1" == dlx ) && "$2" == jest ]]; then
    rest=("${@[3,-1]}")
    __jest_guard "$pm $1 jest" "${rest[@]}" || return 1
  fi
  command "$pm" "$@"
}

jest() { __jest_guard jest "$@" && command jest "$@"; }
npx()  { __jest_wrap npx "$@"; }
pnpm() { __jest_wrap pnpm "$@"; }
yarn() { __jest_wrap yarn "$@"; }
bunx() { __jest_wrap bunx "$@"; }
