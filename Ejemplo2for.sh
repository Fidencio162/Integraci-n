#!/bin/bash
#
mkdir NaClnT46
for i in 0.008 0.006 0.004 0.002 0.001
do
cp seed1C.f ~/NaClnT46
cp prueba1.sh ~/NaClnT46
cd ~/NaClnT46
mv seed1C.f seed$i.f
sed -i "73 s/o_nT1aseed1.dat/o_nT1aseed$i.dat/g" seed$i.f
sed -i "149 s/e_nT1aseed1.dat/e_nT1aseed$i.dat/g" seed$i.f
sed -i "175 s/ic1_nT1aseed1.gro/ic1_nT1aseed$i.gro/g" seed$i.f
sed -i "185 s/ic2_nT1aseed1.gro/ic2_nT1aseed$i.gro/g" seed$i.f
sed -i "197 s/Dsp_nT1aseed1.dat/Dsp_nT1aseed$i.dat/g" seed$i.f
sed -i "204 s/0.025d0/$i"d0"/g" seed$i.f
sed -i "252 s/fc1_nT1aseed1.gro/fc1_nT1aseed$i.gro/g" seed$i.f
sed -i "262 s/fc2_nT1aseed1.gro/fc2_nT1aseed$i.gro/g" seed$i.f
sed -i "296 s/gr11_nT1aseed1.dat/gr11_nT1aseed$i.dat/g" seed$i.f
sed -i "302 s/gr12_nT1aseed1.dat/gr12_nT1aseed$i.dat/g" seed$i.f
sed -i "309 s/gr22_nT1aseed1.dat/gr22_nT1aseed$i.dat/g" seed$i.f
sed -i "357 s/dat_nT1aseed1.dat/dat_nT1aseed$i.dat/g" seed$i.f
sed -i "429 s/ich1_nT1aseed1.gro/ich1_nT1aseed$i.gro/g" seed$i.f
sed -i "430 s/ich2_nT1aseed1.gro/ich2_nT1aseed$i.gro/g" seed$i.f
gfortran seed$i.f -o seed$i
./seed$i &
cd
done
