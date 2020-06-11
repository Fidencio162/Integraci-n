program mc_pi
implicit real*8(a-h,o-z),integer*8(i-n)
parameter(maxpi=1000000000)
iseed=123456789
! open(unit=1,file='pi.dat')
pir=dacos(-1.d0)
pi=0.d0
pi2 = 0.0d0
! calculo de pi. Como promedio de números dentro del circulo unitario 
do i=1, maxpi 
  x=ran2(iseed)
  y=ran2(iseed)
  if((x**2.+y**2.).le.1) then
   pi=pi+1.d0
  endif 
  pif=4.d0*pi/real(i)
  pi2= pi2 + pif**2
enddo 
pi2=pi2/maxpi
! desviación estándar 
sigmaf=dsqrt(pi2-pif**2.)
error=pif-pir
write(*,*) 'pi:', pif 
write(*,*) 'Desviación Estándar:',sigmaf
write(*,*) 'error:', error 
end program mc_pi

!*************************************************************************

FUNCTION RAN2(IDUM)
! RAN2 OF NUMERICAL RECIPES 2ND ED. 
IMPLICIT DOUBLE PRECISION(A-H,O-Z)
PARAMETER (IM1=2147483563,IM2=2147483399,AM=1.0D00/IM1, &
& IMM1=IM1-1,IA1=40014,IA2=40692,IQ1=53668,IQ2=52774,IR1=12211, &
& IR2=3791,NTAB=32,NDIV=1+IMM1/NTAB)
PARAMETER(EPS=1.2D-14,RNMX=1.0D00-EPS)
DIMENSION IV(NTAB)
SAVE IV,IY,IDUM2
DATA IDUM2/123456789/,IV/NTAB*0/,IY/0/
IF (IDUM.LE.0)THEN
IDUM=MAX(-IDUM,1)
IDUM2=IDUM
DO J=NTAB+8,1,-1
K=IDUM/IQ1
IDUM=IA1*(IDUM-K*IQ1)-K*IR1
IF(IDUM.LT.0)IDUM=IDUM+IM1
IF(J.LE.NTAB)IV(J)=IDUM
ENDDO
IY=IV(1)
ENDIF
K=IDUM/IQ1
IDUM=IA1*(IDUM-K*IQ1)-K*IR1
IF(IDUM.LT.0)IDUM=IDUM+IM1
K=IDUM2/IQ2
IDUM2=IA2*(IDUM2-K*IQ2)-K*IR2
IF(IDUM2.LT.0)IDUM2=IDUM2+IM2
J=1+IY/NDIV
IY=IV(J)-IDUM2
IV(J)=IDUM 
IF(IY.LT.1)IY=IY+IMM1
RAN2=MIN(AM*IY,RNMX)
RETURN 
END
