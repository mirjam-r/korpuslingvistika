#Skript loeb kokku, mitu sõna on morfoloogiliselt märgendatud murdetekstis
#Sisendiks kõik kaustas olevad .xml laiendiga failid

#! /bin/tcsh
cat *.xml \
#Iga sõna, mis on eraldatud märgendiga <sone, eraldi reale. Ehk 1 sõna = 1 rida
| sed 's/\(<sone\)/\n\1/g' \
#Jäetakse alles ainult sõned, lausemärgendid jm kaovad.
| grep 'sone' \
#Eemaldatakse intervjueerija tekst, vahemärgid, märgendaja kommentaarid
| grep -v 'meta="intervjueerija"' \
| grep -v 'meta="vahemärk"' \
| grep -v 'meta="kommentaar"' \
#Loendatakse ridade arv, ehk mitu sõne on tekstis
| wc
