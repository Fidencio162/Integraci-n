#!/bin/bash
#
cont=0
while IFS= read -r line
do
	((cont++))
	cd /home/fidencio
cp seed1C.f /home/fidencio/Documentos
cd
cd /home/fidencio/Documentos
mv seed1C.f seed$cont.f
sed -i "73 s/o_nT1aseed1.dat/o_nT1aseed$cont.dat/g" seed$cont.f
sed -i "104 s/123456789/$line/g" seed$cont.f
sed -i "149 s/e_nT1aseed1.dat/e_nT1aseed$cont.dat/g" seed$cont.f
sed -i "175 s/ic1_nT1aseed1.gro/ic1_nT1aseed$cont.gro/g" seed$cont.f
sed -i "185 s/ic2_nT1aseed1.gro/ic2_nT1aseed$cont.gro/g" seed$cont.f
sed -i "197 s/Dsp_nT1aseed1.dat/Dsp_nT1aseed$cont.dat/g" seed$cont.f
sed -i "252 s/fc1_nT1aseed1.gro/fc1_nT1aseed$cont.gro/g" seed$cont.f
sed -i "262 s/fc2_nT1aseed1.gro/fc2_nT1aseed$cont.gro/g" seed$cont.f
sed -i "296 s/gr11_nT1aseed1.dat/gr11_nT1aseed$cont.dat/g" seed$cont.f
sed -i "302 s/gr12_nT1aseed1.dat/gr12_nT1aseed$cont.dat/g" seed$cont.f
sed -i "309 s/gr22_nT1aseed1.dat/gr22_nT1aseed$cont.dat/g" seed$cont.f
sed -i "357 s/dat_nT1aseed1.dat/dat_nT1aseed$cont.dat/g" seed$cont.f
sed -i "429 s/ich1_nT1aseed1.gro/ich1_nT1aseed$cont.gro/g" seed$cont.f
sed -i "430 s/ich2_nT1aseed1.gro/ich2_nT1aseed$cont.gro/g" seed$cont.f
cd
done < RandomNumbers.dat
