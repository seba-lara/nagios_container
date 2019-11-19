WARNING_LIMIT=$1
CRITICAL_LIMIT=$2

DISCOS=( $(df | awk '{print $5}' | sed 's/%//g' ) )

for i in "${DISCOS[@]}"
do
  if [[ ${i} == "Use" ]]
  then
    continue
  else
    # Check if % is CRITICAL_LIMIT or higher
    if [[ ${i} -ge $CRITICAL_LIMIT ]]
    then
      # Exit code HERE - Critical
      echo "Particion sobre $CRITICAL_LIMIT"
      exit 2
    fi
    # Check if % is between WARNING_LIMIT to CRITICAL_LIMIT
    if [[ ${i} -ge $WARNING_LIMIT ]]
    then
      # Exit code HERE - Warning
      echo "Particion sobre $WARNING_LIMIT"
      exit 1
    fi
  fi
done
 # Exit code HERE - Normal
echo "Discos OK"
exit 0
