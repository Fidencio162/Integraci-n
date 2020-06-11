  ! Fidencio Pérez Hernández
	! Abril, 2020
	program MonteCarlo
     	implicit integer*8(i-n),real*8(a-h,o-z)
	parameter(nm=5000)
	common/constantInt/ np,npt,npr
	common/variablesR/ TEMP,RHO,x(nm),y(nm),z(nm)
	common/energ/ slambda,EPS,CORE
	common/grdr/ dr, gr(nm),r(nm)
	common/topo/ box,rc
	open(unit=8,file='config.gro')
	delta1=0.5d0
	CORE=1.D0
	slambda=CORE+0.8
	EPS=1.D0
	LB=0.7e-9
	dr=0.002
	pi=dacos(-1.d0)

	iseed=123456789
	natt=0
	nacc=1
	call Inputs

	call cfcc
!	---------------------------------------------------------------
!			generate .gro file
!	---------------------------------------------------------------
	open(unit=31,file='Energy.dat')
	open(unit=21,file='grLJ.dat')
	l=1
	     write(8,98) l
	       write(8,99) np
	       do i=1,np
	         write(8,100) i,x(i),y(i),z(i)
	       enddo
	     write(8,101) enertot/np*temp,enertot/np*temp,enertot/np*temp

	  do l=2,npt
	    call mov(delta1,enertot,natt,nacc,iseed)
!**********************************
          if(mod(l,1000) .eq. 0 )then
	     write(8,98) l
	       write(8,99) np
	       do i=1,np
	         write(8,100) i,x(i),y(i),z(i)
	       enddo
	     write(8,101) enertot/np*temp,enertot/np*temp,enertot/np*temp
	    write(31,101) l/100.0,enertot/np*temp, real(nacc)/real(natt)
	   write(32,101) l/100.0,sigmae
          endif
!**********************************
	  enddo

!------------------------------------------------------------------------
	enerk=0.0d0
	enerk2=0.d0
	  do l=2,npr
	    call mov(delta1,enertot,natt,nacc,iseed)
	    enerk= enerk+enertot/np*temp
		enerf= enerk/real(l)
	        enerk2=enerk2+(enertot/np*temp)**2.
!	  sigmae=dsqrt(enerk2-enerf**2.)
!**********************************
          if(mod(l,1000) .eq. 0 )then
	     write(8,98) l
	       write(8,99) np
	       do i=1,np
	         write(8,100) i,x(i),y(i),z(i)
	       enddo
	     write(8,101) enertot/np*temp,enertot/np*temp,enertot/np*temp
	    write(31,101) l/100.0,enertot/np*temp, real(nacc)/real(natt)
	   write(32,101) l/100.0,sigmae
          endif
!**********************************
!	  print*, "Desviacion Estandar_i:", sigmae
	  enddo
	sigma2=enerk2/npr-enerf**2
	sigmae=dsqrt(enerk2/npr-enerf**2.)
	Cv=sigma2/(np*(enerf*temp)**2)
	
	print*,'Cv:', Cv
	print*, "Desviacion Estandar:", sigmae
	print*, "ENERGIA PROMEDIO:", enerf
	print*, 'pres:', enerf/core**3
	print*, 'beta:' ,Temp*enerf
	print*, 'beta*p:', Temp*enerf**2/core**3
	print*, 'rho:', rho

!	r=0.d0
!	gr=0.d0
!	do i=1,nm
!	  r(i)=i*dr

!	enddo
!	ncp=0
!	do j=1,npr
!	call mov(delta1,enertot,natt,nacc,iseed)
!	if(mod(j,100).eq. 0) then
!	  enerk= enerk+enertot/np*temp
!	   enerf= enerk/real(j)
!	call rdf(x,y,z)
!	  ncp=ncp+1
!	write(21,*) r, gr
!	endif
!	enddo
!	write(21,*) r,gr/ncp
	
!	do i=1,npr
!	vr=4*pi*(r(i)-0.5*dr)**2*dr
!	gid=rho*vr
!	gr(i)=gr(i)/(gid*np)
!	write(21,*) r(i)-0.5*dr , gr(i)/ncp
!	enddo
	

   98	format(x,'CONFIGURACION',11x,i9)
   99	format(20x,i5)
  100 	format(5x,'1',2x,'Sol',4x,'C',2x,i5,3f8.3,2x,'0.0000',2x,
     +    '0.0000',2x,'0.0000')
  101	format(3f15.3)
!	---------------------------------------------------------------
	end program
	
!	---------------------------------------------------------------
!	-----------------------Inputs Constant-------------------------
!	---------------------------------------------------------------
	subroutine Inputs
      implicit integer*8(i-n),real*8(a-h,o-z)
	parameter(nm=5000)
	common/constantInt/ np,npt,npr
	common/variablesR/ TEMP,RHO,x(nm),y(nm),z(nm)
	open(unit=1,file='inputs.dat')
	open(unit=2,file='output.dat')
	read(1,*) TEMP
	read(1,*) np
	read(1,*) rho
	read(1,*) npt
	read(1,*) npr
!	WRITE(*,10)
	write(2,10)
	write(2,20) TEMP
   10	format(1X,'CONDICIONES DE SIMULACION',/)
   20	format(3x,f20.10)
	return
	end
!	---------------------------------------------------------------
!				displacement
!	---------------------------------------------------------------
	subroutine mov(delta1,enertot,natt,nacc,iseed)
      	implicit integer*8(i-n),real*8(a-h,o-z)
	parameter(nm=5000)
	common/constantInt/ np
	common/variablesR/ TEMP,RHO,x(nm),y(nm),z(nm)
	common/topo/ box,rc

	natt=natt+1
  
      
	i = Int(ran2(iseed)*np)+1

      xo = x(i)
      yo = y(i)
      zo = z(i)

      call Ener(i,xo,yo,zo,enero)

      xn=x(i)+delta1*(ran2(iseed)-0.5d0)
      yn=y(i)+delta1*(ran2(iseed)-0.5d0)
      zn=z(i)+delta1*(ran2(iseed)-0.5d0)

      xn=xn-box*dnint(xn/box)
      yn=yn-box*dnint(xn/box)
      zn=zn-box*dnint(zn/box)

      call Ener(i,xn,yn,zn,enern)

        dener = enern-enero

      if(ran2(iseed) .lt. dexp(-dener)) then
          nacc=nacc+1
          enertot = enertot + dener
        x(i) = xn
        y(i) = yn
        z(i) = zn
        endif
	call adjust(natt,nacc,dr)
	return
	end
	
	subroutine adjust(nattemp,nacc,dr)
      	implicit integer*8(i-n),real*8(a-h,o-z)
      	if (mod(nattemp,10000) .eq. 0) then
         ratio = real(nacc)/real(nattemp)
         if (ratio .gt. 0.3d0) then
            if (dr .lt. 3.0d0) then
               dr = dr*1.05
            endif
         else
            if (dr .gt. 0.01d0) then
               dr = dr*0.95
            endif
         endif
      	endif
      	return
      	end	


	subroutine Ener(j,xj,yj,zj,enertot)
      	implicit integer*8(i-n),real*8(a-h,o-z)
	common/energ/ slambda,EPS,CORE
	parameter(nm=5000)
	common/constantInt/ np
	common/variablesR/ TEMP,RHO,x(nm),y(nm),z(nm)
	common/topo/ box,rc
	Uj=0.D0
	do i=1,j-1
	dx=x(i)-xj
	dy=y(i)-yj
	dz=z(i)-zj
	dx=dx-box*dnint(dx/box)
	dy=dy-box*dnint(dy/box)
	dz=dz-box*dnint(dz/box)
	   r=dsqrt(dx**2.+dy**2.+dz**2.)
	   if (r.le. rc) then
		U=4*((1/r)**12-(1/r)**6)
	    Uj=Uj+U
	   endif
	enddo
!	para este ciclo i=j+1	
	do i=j+1,np
	dx=x(i)-xj
	dy=y(i)-yj
	dz=z(i)-zj
	dx=dx-box*dnint(dx/box)
	dy=dy-box*dnint(dy/box)
	dz=dz-box*dnint(dz/box)
	   r=dsqrt(dx**2+dy**2+dz**2)
	   if (r.le. rc) then
	        U=4*((1/r)**12-(1/r)**6)
	    Uj=Uj+U
	   endif
	enddo
            enertot = Uj/temp
	return
	end

	subroutine rdf()
	implicit double precision(A-H,O-Z)
	parameter(nm=5000)
	common/constantInt/ np
	common/variablesR/ TEMP,RHO,x(nm),y(nm),z(nm)
	common/topo/ box,rc
	common/grdr/ dr,gr(nm),r(nm)



	nbin=0
	do i=1,np-1
	  do j=i+1,np
	   dx=x(i)-x(j)
	   dy=y(i)-y(j)
	   dz=z(i)-z(j)
	   dx=dx-box*dnint(dx/box)
	   dy=dy-box*dnint(dy/box)
	   dz=dz-box*dnint(dz/box)
	   r12=dsqrt(dx**2.+dy**2.+dz**2.)
	   nbin=int(r12/dr)+1
	    gr(nbin)=gr(nbin)+2.d0
	   enddo
	enddo
	return
	end
	
!	---------------------------------------------------------------
!			        Lattice FCC
!	---------------------------------------------------------------
	subroutine cfcc
      	implicit integer*8(i-n),real*8(a-h,o-z)
   	 parameter(nm=5000)
	common/constantInt/ np
	common/variablesR/ TEMP,RHO,x(nm),y(nm),z(nm)
	common/topo/ box,rc

	box  = (np/rho)**(1./3.)
	rc = box/2.0d0
	del  = (box**3)**(1./3.)
	n    = NINT((np/(4.0))**(1./3.))  

	del  = del/(n)
	itel = 0

	open(unit=3,file='Latice.xyz')
	n = nint(2.0d0*rc/ del / 1.5d0)

	do i = 0, n +1
         do j = 0, n +1 
            do k = 0, n +1 
               X(itel+1) = k*del
               Y(itel+1) = j*del
               Z(itel+1) = i*del
               X(itel+2) = (k+0.5)*del
               Y(itel+2) = (j+0.5)*del
               Z(itel+2) = i*del
               X(itel+3) = k*del
               Y(itel+3) = (j+0.5)*del
               Z(itel+3) = (i+0.5)*del
               X(itel+4) = (k+0.5)*del
               Y(itel+4) = j*del
               Z(itel+4) = (i+0.5)*del
               itel      = itel + 4
            enddo
         enddo
	enddo


	xcm = 0.0d0
	ycm = 0.0d0
	zcm = 0.0d0

	do i = 1,np
         xcm = xcm + x(i)
         ycm = ycm + y(i)
         zcm = zcm + z(i)
	enddo

	xcm = xcm / np
	ycm = ycm / np
	zcm = zcm / np
	write(3,49) np
	write(3,50)
	do i = 1,np
         x(i) = x(i) - xcm
         y(i) = y(i) - ycm
         z(i) = z(i) - zcm
	write(3,51) x(i), y(i), z(i)
	enddo
	close(3)



   50	format(x,'CONFIGURACION INICIAL')
   51	FORMAT(3X,'C',3f10.5)
   49	format(2x,i5)
	return
     	end

      FUNCTION RAN2(Idum)
      IMPLICIT NONE

!************************************************************************* 

      INTEGER Idum, IM1, IM2, IMM1, IA1, IA2, IQ1,
     & IQ2, IR1, IR2, NTAb,NDIv
      REAL RAN2, AM, EPS, RNMx
      PARAMETER (IM1=2147483563, IM2=2147483399,
     & AM=1./IM1, IMM1=IM1-1,IA1=40014, IA2=40692,
     & IQ1=53668, IQ2=52774, IR1=12211,IR2=3791,
     & NTAb=32, NDIv=1+IMM1/NTAb, EPS=1.2E-7, RNMx=1.-EPS)
      INTEGER idum2, j, k, iv(NTAb), iy
      SAVE iv, iy, idum2
      DATA idum2/123456789/, iv/NTAb*0/, iy/0/
      IF (Idum.LE.0) THEN
         Idum = MAX(-Idum, 1)
         idum2 = Idum
         DO j = NTAb + 8, 1, -1
            k = Idum/IQ1
            Idum = IA1*(Idum-k*IQ1) - k*IR1
            IF (Idum.LT.0) Idum = Idum + IM1
            IF (j.LE.NTAb) iv(j) = Idum
         END DO
         iy = iv(1)
      END IF
      k = Idum/IQ1
      Idum = IA1*(Idum-k*IQ1) - k*IR1
      IF (Idum.LT.0) Idum = Idum + IM1
      k = idum2/IQ2
      idum2 = IA2*(idum2-k*IQ2) - k*IR2
      IF (idum2.LT.0) idum2 = idum2 + IM2
      j = 1 + iy/NDIv
      iy = iv(j) - idum2
      iv(j) = Idum
      IF (iy.LT.1) iy = iy + IMM1
      RAN2 = MIN(AM*iy, RNMx)
      RETURN
      END
