  program StructureF
	integer i,m,nmax,mmax,nf
	parameter (nmax=16384, mmax=11263)
	double precision r(nmax),g(nmax),q(mmax),Sk(mmax),h(nmax)
	double precision NAvogadro,kBoltzman,Temperatura,viscosidad
	double precision a2,nT,a1d,a2d,pi,a1,nTM,drN,s1,sN,delr,s
	real*8 d,e,D1,D2,x1,x2
	common/trapecio/pi
!	--------------------------------------------
!	------------  Inputs constant  -------------
!	--------------------------------------------
	NAvogadro=6.02214179e+23
	kBoltzman=1.380658e-23
	Temperatura=273.15+25
	viscosidad=0.89e-3
	e=1.602176565e-19
	D1=1.33e-9
	D2=2.03e-9
	nTM=2.d0
	pi=acos(-1.d0)
	a1=(kBoltzman*Temperatura)/(4*pi*viscosidad*D1)
	a2=(kBoltzman*Temperatura)/(4*pi*viscosidad*D2)
	nT=nTM*NAvogadro*1e+3
	d=nT**(-1/3)
	a1d=a1/d
	a2d=a2/d
!	--------------------------------------------
	call Trapz1(n,m)
	end program StructureF
!	--------------------------------------------
	
	subroutine Trapz1(n,m)
	integer n,m,nf
	parameter (nmax=16384, mmax=11263)
	double precision r(nmax),g(nmax),q(mmax),Sk(mmax),h(nmax)
	double precision pi,s1,sN,delr,s,x1,x2
	common/trapecio/pi
	open(unit=3,file="S11n2.dat")
	open(unit=1,file='Sk_11.dat')
	open(2,file='gr_11.dat')
	x1=0.5d0
	x2=0.5d0
	do m=1,mmax
		read(1,*) q(m), Sk(m)
	enddo
	do n=1,nmax
		read(2,*) r(n), g(n)
		h(n)=g(n)-1.d0
	enddo
	close(2)
!	-------------------------------------------
	do m=1,mmax
		s=0.0d0	!inicialización
		nf=nmax-5835
		s1=dsin(q(m)*r(1))*h(1)*(r(2)-r(1))*r(1) !Extremo inferior de integracion
		sN=dsin(q(m)*r(nf))*h(nf)*(r(nf)-r(nf-1))*r(nf) !Extremo superior de integracion
	do n=3,nf-1
		delr=r(n)-r(n-2)	!pasos de integración
		s=s+(dsin(q(m)*r(n+1))*h(n+1)*delr*r(n+1)+s1+sN)/q(m) ! Suma iterativa del método. Ec (3) de las notas.
   	end do
		s=0.5*4*pi*x1*s	! Resultado final de la integración el factor 0.5 es del método como se muestra en la Ec. (3).
		write(3,20) q(m),s+1.d0
	end do
   	close(1)
	close(3)
   20		format(e26.19,3x,e26.19)
	return
	end
