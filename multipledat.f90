program multipledat
	implicit double precision (a-h,o-z)
	parameter (nseed=80,mmax=3507)
	dimension r(mmax),grseed(mmax),gr(mmax)
	CHARACTER(len=13) cn11
	character(len=1) cnum1
	CHARACTER(len=2) cnum2
	character(len=15) cn2
	character(len=19) cn3
	character(len=18) cn4
	
	open(unit=241,file='hr11nT9.dat')
	cn11='gr11_nT1aseed'
	do i=1,9
	write(cnum1,'(i1)') i
	cn4=cn11//trim(cnum1)//'.dat'
	open(unit=i,file=cn4)
	enddo
	
	do i=10,nseed
	write(cnum2,'(i2)') i
	cn2=cn11//trim(cnum2)
	cn3=cn2//'.dat'
	  open(unit=i,file=cn3)
	enddo
	!--------------------------------------------------------------
	do k=1,mmax
	  do i=1,nseed
	    read(i,*) r(k),grseed(k)
	    gr(k)=gr(k)+grseed(k)
	  enddo
	  gr(k)=gr(k)/nseed
	  write(241,*) r(k),gr(k)-1.d0
	enddo
end program
