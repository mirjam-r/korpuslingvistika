cat *.xml \
| sed 's/\(<lause\)/\n\1/g' \
| sed 's/\(<sone[^>]*>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone><sone id="[^"]*" [^=]*=\?"\?[^"]*"\? \?lemma="[^"]*" [^=]*=\?"\?[^"]*"\? \?vorm="[^\.]*\.ab."\)/#\1/g' \
| tr '#' '\n' | sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone>\).*$/\1/g' | grep '\.ab\.' \
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*\)/\1#/g' \
| sed 's/vorm="\([^\.]*\.ab\.\)"/>\.\1<\/sone/g' \
| sed 's/\(liik="Pre">[^<]*\)/\1;ilma/g' \
| sed 's/\(<\/sone\)/@\1/g' \
| grep -w 'ilma' \
| sed 's/<[^>]*>//g' \
| tr '@' ' ' \
| sed 's/ \.\([^\.]*\.ab\.\) /;\1;/' \
| sed 's/# /;/' \
| sed 's/^/KIRDE;/' 
> /home/pohl01/m/mruutma1/murded/ilma_abessiiv.txt
