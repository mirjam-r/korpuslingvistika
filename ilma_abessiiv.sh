# Skripti eesmärgiks on leida murdekorpuse materjalist abessiivi esinemisjuhud, kus abessiiv esineks koos kaassõnaga 'ilma'
# Ehk eesmärgiks on leida üksused, kus millegi puudumist on väljendatud analüütiliselt.
# Skript on sama, mis 'adessiiv.sh'
# KESK;onn ilma;ilma;sg.ab.;korstnatta;


#! /bin/tcsh
cat *.xml \
| sed 's/\(<lause\)/\n\1/g' \
| sed 's/\(<sone[^>]*>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone><sone id="[^"]*" [^=]*=\?"\?[^"]*"\? \?lemma="[^"]*" [^=]*=\?"\?[^"]*"\? \?vorm="[^\.]*\.ab."\)/#\1/g' \
| tr '#' '\n' \
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone>\).*$/\1/g' \
| grep '\.ab\.' \
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*\)/\1#/g' \
| sed 's/vorm="\([^\.]*\.ab\.\)"/>\.\1<\/sone/g' \
| sed 's/\(liik="Pre">[^<]*\)/\1;ilma/g' \
| sed 's/\(<\/sone\)/@\1/g' \
| grep -w 'ilma' \
| sed 's/<[^>]*>//g' \
| tr '@' ' ' \
| sed 's/ \.\([^\.]*\.ab\.\) /;\1;/' \
| sed 's/# /;/' \
| sed 's/^/KESK;/'
# Seejärel moodustatakse väljundfail.
### !!!!Kuna väljundfaili lisatakse ka teiste murdealade tulemused, peab kirjutama täpse teekonna, kuhu väljundfail salvestatakse.
# !!!!! Teekond muuda enda kausta teekonnaks.
# > /home/pohl01/m/mruutma1/murded/ilma_abessiiv.txt
#Teiste murrete ilma+abessiivi esinemiste saamiseks peab skripti käivitama mõne teise murde kaustas, nt idamurde.
#Tulemuse saab salvestada alati samasse faili, skripti viimaseks reaks on siis aga edaspidi (muude teekond enda kausta teekonnaks):
#sed 's/^/IDA;/' >> /home/pohl01/m/mruutma1/murded/ilma_abessiiv.txt
