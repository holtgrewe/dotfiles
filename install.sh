#!/bin/bash
#
# USAGE: install.sh [--overwrite]

if ! which stow >/dev/null; then
  >&2 echo "ERROR: Command 'stow' not found."
  exit 1
fi

if [[ "$*" == *--overwrite* ]]; then
  >&2 echo "WARNING: You specified the --overwrite option. This will *overwrite* files."
  >&2 echo "WARNING: Type 'YES' if you are certain."
  >&2 echo -n "Are you certain?> "
  read answer
  if [[ "$answer" == "YES" ]]; then
    overwrite="--adopt"
  else
    >&2 echo 'OK, bailing out of here!'
    exit 1
  fi
else
  >&2 echo "NOTE: if stow refuses to overwrite files then"
  >&2 echo "NOTE:"
  >&2 echo "NOTE: (1) make a backup of the files"
  >&2 echo "NOTE: (2) call install.sh as 'install.sh --overwrite'"
  >&2 echo ""
  overwrite=
fi

stow $overwrite bash
stow $overwrite mutt
stow $overwrite vim
stow $overwrite keychain
stow $overwrite git

>&2 echo "All done. Have a nice day!"
