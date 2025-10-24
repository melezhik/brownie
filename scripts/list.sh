curl https://raw.githubusercontent.com/Raku/REA/main/META.json -s \
| jq -r '.[] | .name' | sort | uniq

