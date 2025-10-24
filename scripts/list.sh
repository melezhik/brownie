curl https://raw.githubusercontent.com/Raku/REA/main/META.json -s | jq '.[] | .name' | sort | uniq

