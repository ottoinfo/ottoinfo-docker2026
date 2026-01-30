#!/bin/bash
locale options
options+=("Quit")
options+=(". ~/.bash_custom_aliases")
options+=("yarn tspc --project tsconfig.node.json")
options+=("yarn rollup --config rollup.node.ts --configPlugin typescript")
options+=("yarn tspc --project tsconfig.express.json")
options+=("yarn rollup --config rollup.express.ts --configPlugin typescript")

#
echo "Select an option:"
select opt in "${options[@]}"; do
  if [[ -n "$opt" ]]; then
    echo -e "\nYou selected: $opt \n"

    break
  else
    echo -e "\nInvalid selection. Please try again.\n"
  fi
done
