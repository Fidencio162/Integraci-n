#!/bin/bash
#
for((num=3; num<=51; num++)); do
cp prueba1.sh ~/NaCln31
cd ~/NaCln31
mv prueba1.sh prueba$num.sh
sed -i  "11 s/seed1C/seed$num/g" prueba$num.sh
sbatch prueba$num.sh
cd
#echo "el contador es $num"
done
