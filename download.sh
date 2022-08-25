# Downloads a contract's source code from etherscan
address=0x922dC160f2ab743312A6bB19DD5152C1D3Ecca33
curl "https://api.etherscan.io/api?module=contract&action=getsourcecode&address=$address" \
	| jq -r '.result[0].SourceCode' | sed -e 's/^.//' \
	| jq -c '.sources | to_entries[]' | tr '\n' '\0' | xargs -0 -n1 sh -c \
	'f=`jq -r ".key" <<< $0` && mkdir -p `dirname $f` && jq -r ".value.content" <<< "$0" > $f'
