find "${1:-.}" -type f \
  -not -path '*/.*' 2>/dev/null | sort | while read -r f; do
  echo -e "\n--- $f ---\n"
  cat "$f"
done

