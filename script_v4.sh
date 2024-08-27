#!/bin/bash

dominioalvo=$1

echo "----------------------"
echo $(date)
echo "Executando Subfinder" 
echo "----------------------"
subfinder -d $1 -silent > lista.txt

echo "----------------------"
echo $(date)
echo "Executando Findomain"
echo "----------------------"
findomain -t $1 -q >> lista.txt

echo "----------------------"
echo $(date)
echo "Executando Sort Uniq -> Httpx"
echo "----------------------" 
sort lista.txt | uniq -c | awk '{print $2}' | httpx > lista_unica_simples.txt

echo "----------------------"
echo $(date)
echo "Excutando Httpx Tech Status Code 200 only"
echo "----------------------"
cat lista_unica_simples.txt | httpx --tech-detect -silent -sc | grep "200" | cut -d " " -f1  > lista_unica_simples_sc200.txt

echo "----------------------"
echo $(date)
echo "Excutando Httpx Tech Status Code 200 e Screenshot"
echo "----------------------"
cat lista_unica_simples_sc200.txt | httpx --tech-detect -silent -sc -ss

echo "----------------------"
echo "Executando Ferox Buster com a lista simples sc200"
echo "----------------------"
for i in $(cat lista_unica_simples_sc200.txt); do echo "URL: $i"; feroxbuster -u $i -w wl_100.txt -s 200 -d 1 --silent >> buster_output.txt; done

echo "----------------------"
echo $(date)
echo "Executando Portscan con Naabu e Nmap"
echo "----------------------"
cat lista_unica_simples_sc200.txt | naabu -silent -nmap-cli 'nmap -sV -sC' > portscan.txt

echo "----------------------"
echo "Executando Nuclei com a lista simples sc200"
echo "----------------------"
nuclei -t ssl -l lista_unica_simples_sc200.txt > nuclei_output.txt

echo "----------------------"
echo "Excução finalizada"
echo $(date)
echo "----------------------"
