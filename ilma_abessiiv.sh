# Skripti eesmärgiks on leida murdekorpuse materjalist abessiivi esinemisjuhud, kus abessiiv esineks koos kaassõnaga 'ilma'
# Ehk eesmärgiks on leida üksused, kus millegi puudumist on väljendatud analüütiliselt.
# Väljundiks on semikoolonitega eraldatud list, mida saab hiljem Excelis tabeliks teha ja käsitsi üle kontrollida. 
# Näide väljundist:
# VORU;nii ilm;ilma;sg.ab.;armutta;`pes't'i 
# Sisendiks on .xml laiendiga murdekorpuse morfoloogiliselt märgndatud failid.
# Sisendfailid peavad olema murrete kaupa eraldi kaustades
# !!! Skript käivitatakse igas kaustas eraldi!
# Esimesena peabki minema kausta, kus murdeala .xml failid on.
# Skripti täpsemad etappide kommentaarid on failis abessiiv.sh. Kohad, kus miskit on muudetud, on kommenteeritud selle skripti vahele.

#! /bin/tcsh
cat *.xml \
| sed 's/\(<lause\)/\n\1/g' \
| sed 's/\(<sone[^>]*>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone><sone id="[^"]*" [^=]*=\?"\?[^"]*"\? \?lemma="[^"]*" [^=]*=\?"\?[^"]*"\? \?vorm="[^\.]*\.ab."\)/#\1/g' \
| tr '#' '\n' \
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone>\).*$/\1/g' \
| grep '\.ab\.' \
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*\)/\1#/g' \
| sed 's/vorm="\([^\.]*\.ab\.\)"/>\.\1<\/sone/g' \
# Kuna lõplikus andmestikus peaks olema 'ilma'-kaassõna lemma vorm, lisatakse märgendatud 'ilma' lõppu 'ilma' lemma.
| sed 's/\(liik="Pre">[^<]*\)/\1;ilma/g' \
| sed 's/\(<\/sone\)/@\1/g' \
# Jäetakse alles ainult read, kus esineb 'ilma' ehk ära kaovad sünteetilised variandid
| grep -w 'ilma' \
| sed 's/<[^>]*>//g' \
| tr '@' ' ' \
| sed 's/ \.\([^\.]*\.ab\.\) /;\1;/' \
| sed 's/# /;/' \
| sed 's/^/KESK;/' 
# > /home/pohl01/m/mruutma1/murded/ilma_abessiiv.txt
