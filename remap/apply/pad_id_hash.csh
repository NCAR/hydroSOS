#!/bin/csh

# first sort 
sort -n smhi_id_index.txt > smhi_id_index.srt.txt

# then pad
awk 'BEGIN{last=0}{if($1==last+1){print}else{print last+1,-99};last=last+1}' smhi_id_index.srt.txt > smhi_id_index.filled.txt

# then add a header row with eg "smhi_id data_index"
