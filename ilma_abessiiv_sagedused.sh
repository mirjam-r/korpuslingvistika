#Skripti väljundiks on fail, kus on ilma+abessiivi esinemise sagedused murdealade kaupa.
#Sisendiks fail 'ilma_abessiiv.txt' (leiad repositooriumist)

#! /bin/tcsh
cat ilma_abessiiv.txt \
#Kustutab ülearuse info ja jätab alles ainult murdeala
| sed 's/\([^;]*\);.*$/\1/' \
#Sagedusloend tähestikulises järjekorras
| sort | uniq -c | sort -nr > ilma_abessiiv_sagedused.txt
