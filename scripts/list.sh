curl https://raw.githubusercontent.com/Raku/REA/main/META.json -s \
| jq -r '.[] | .name' | shuf | tail -n 100

