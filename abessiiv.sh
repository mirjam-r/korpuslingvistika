# Skripti eesmärgiks on leida murdekorpuse materjalist abessiivi esinemisjuhud, kus abessiiv esineks üksinda, ilma kaassõnata 'ilma'
# Ehk eesmärgiks on leida üksused, kus millegi puudumist on väljendatud sünteetiliselt.
# Väljundiks on semikoolonitega eraldatud list, mida saab hiljem Excelis tabeliks teha ja käsitsi üle kontrollida. 
# Skripti väljundis on seega igal eraldi real järgmine info:
# Murdeala; kontekst (2 sõna); morfoloogiline info; abessiivi käändes sõna; kontekst (1 sõna)
### Igas reas ei leidu siiski konteksti juures kahte sõna, sest mõned abessiivid esinevad lause lõpus või alguses.
# Näide väljundist:
# IDA;jääb poolel'i;sup.ab.;`võtmada;vaja
# Sisendiks on .xml laiendiga murdekorpuse morfoloogiliselt märgndatud failid.
# Sisendfailid peavad olema murrete kaupa eraldi kaustades
# !!! Skript käivitatakse igas kaustas eraldi!
# Esimesena peabki minema kausta, kus murdeala .xml failid on.

#! /bin/tcsh
# Skript loeb kõiki kaustas olevaid .xml laiendiga faile
cat *.xml \
# Laused peavad olema eraldi real: Eesmärk on eemaldada ilma+abessiiv juhud ja selle kaassõnafraasi osad ei esine kunagi eraldi lausetes.
| sed 's/\(<lause\)/\n\1/g' \
# Järgmisega piiratakse adessiivi ümber olev kontekst: kahe sõna kaugusele enne adessiivi tuleb märgend #
| sed 's/\(<sone[^>]*>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone><sone id="[^"]*" [^=]*=\?"\?[^"]*"\? \?lemma="[^"]*" [^=]*=\?"\?[^"]*"\? \?vorm="[^\.]*\.ab."\)/#\1/g' \
# Märgend # asendatakse reavahetusega, et väljundis oleks eraldi a) read, kus ei ole abessiivi b) read kus on abessiiv, abessiivi ees olev
#kontekst ja kõik, mis järgneb abessiivile
| tr '#' '\n' \
# Jäetakse alles ainult üks üksus pärast abessiivi
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*<\/sone><sone[^>]*>[^<]*<\/sone>\).*$/\1/g' \
# Jäetakse alles ainult read, kus esineb abessiiv
| grep '\.ab\.' \
# Siin lisatakse abessiivis sõna taha #, sest seda üksust soovitakse hiljem eraldada semikooloniga. Hiljem semikoolonit pole sinna
#võimalik lisada, sest ainus, mis hiljem eraldab seda üksust teistest, on tühik. Tühikut aga ei saa muuta semikooloniks, sest
#kahe kontekstiüksuse vahel on samuti tühik, mis peaksid väljundisse alles jääma. Seega asendatakse # hiljem semikooloniga
| sed 's/\(\.ab\."[^=]*=\?"\?[^"]*"\? \?>[^<]*\)/\1#/g' \
#Kuna lõplikus väljundis peaks alles jääma abessiivis sõna morfoloogiline info, aga muude üksuste info pole uurimise mõttes oluline,
#märgitakse abessiivi mof.info juurde märgendid > ja </sone. Nende märgendite vahel on alati sõna, mida on märgendatud, seega kui märkida
#morfoloogiline info nende tähistega, saab hiljem kõik muud märgendid ära kustutada ja alles jääb nii abessiivi morfoloogiline info kui ka
#kõik muud märgendatud sõnad.
| sed 's/vorm="\([^\.]*\.ab\.\)"/>\.\1<\/sone/g' \
#Iga eraldi üksuse vahele tuleb @, mis hiljem muudetakse sõnadevaheliseks tühikuks.
| sed 's/\(<\/sone\)/@\1/g' \
#Eemaldatakse read, kus esineb 'ilma' ehk alles jäävad vaid sünteetilised juhud.
| grep -v 'ilma' \
#kustutakse ülearused morfoloogilised märgendid
| sed 's/<[^>]*>//g' \
| tr '@' ' ' \
#morfoloogiline info eraldatakse semikooloniga
| sed 's/ \.\([^\.]*\.ab\.\) /;\1;/' \
| sed 's/# /;/' \
# Iga rea ette lisatakse murdeala, mille faile parasjagu on vaadatud.
| sed 's/^/KESK;/' \
# Seejärel moodustatakse väljundfail.
### !!!!Kuna väljundfaili lisatakse ka teiste murdealade tulemused, peab kirjutama täpse teekonna, kuhu väljundfail salvestatakse.
# !!!!! Teekond muuda enda kausta teekonnaks.
# > /home/pohl01/m/mruutma1/murded/abessiiv.txt
#Teiste murrete abessiivi esinemiste saamiseks peab skripti käivitama mõne teise murde kaustas, nt idamurde.
#Tulemuse saab salvestada alati samasse faili, skripti viimaseks reaks on siis aga edaspidi (muuda teekond enda kausta teekonnaks):
#sed 's/^/IDA;/' >> /home/pohl01/m/mruutma1/murded/abessiiv.txt
