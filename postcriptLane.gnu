set terminal postscript
set output "Lane-Emden1.ps"
set lmargin 6
set rmargin 6
set title "Solucion de la Ecuacion de Lane-Emden"
plot "field.plt"
pause mouse
reset
