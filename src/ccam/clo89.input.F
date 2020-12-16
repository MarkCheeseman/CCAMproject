#line 1 "/p9/dug/teamhpc/sw/CCAMproject/src/ccam/clo89.f"
      subroutine clo89
c 
CDIR$ TASK COMMON CLDCOM
CDIR$ TASK COMMON RADISW
c CDIR$ TASK COMMON VTEMP

c     subroutine clo88 computes cloud transmission functions for the
c  longwave code,using code written by bert katz (301-763-8161).
c  and modified by dan schwarzkopf in december,1988.
c                inputs:          (common block)
c      camt,ktop,kbtm,nclds,emcld   radisw
c                output:  
c      cldfac                       cldcom
c 
c          called by:      radmn or model routine 
c          calls    : 
c 
      use newmpar_m
      use parm_m
      use radisw_m
      use cldcom_m

      include 'rdparm.h'
c 
      real tempc(lp1,lp1),cldfip(lp1,lp1) ! MJT CHANGE - mr
      real cldfip1(lp1,lp1)       ! MJT CHANGE - mr
      integer pos(1),nc1,nc2,nc3  ! MJT CHANGE - mr
      logical ctest(lp1)          ! MJT CHANGE - mr
c 
      if (nmr.eq.2) then ! MJT CHANGE - mr

        do ip=1,imax
          tempc(:,:)=1.
          nc=1
          do while (nc.le.nclds(ip))
            nc1=nc ! nc = bottom of cloud block
            ! search for top of cloud block
            do while(kbtm(ip,nc1+2).eq.ktop(ip,nc1+1)-1
     &               .and.nc1.lt.lp1.and.kbtm(ip,nc1+2).gt.1)
              nc1=nc1+1 ! nc1= top of cloud block
            end do
            ctemp=0.
            ctest=.false.
            ctest(nc:nc1)=.true. ! cloud layers in current path through cloud block
            cldfip1=0.
            ! loop over possible paths through cloud
            do while (any(ctest(nc:nc1)))
              pos=minloc(camt(ip,nc+1:nc1+1),ctest(nc:nc1))
              nc2=pos(1)-1+nc ! level of smallest cloud fraction from remaning levels
              ctemp=camt(ip,nc2+1)-ctemp ! overlap fraction for current path
              cldfip(:,:)=1.
              ! calculate transmission through cloud levels for the current path
              do nc3=nc,nc1
                if (ctest(nc3)) then ! only select clouds in current path
                  xcld=1.-emcld(ip,nc3+1) ! xcld=transmission
                  k1=ktop(ip,nc3+1)+1
                  k2=kbtm(ip,nc3+1)
                  cldfip(1:k2,k1:lp1)=cldfip(1:k2,k1:lp1)*xcld
                  cldfip(k1:lp1,1:k2)=cldfip(k1:lp1,1:k2)*xcld
                end if
              end do
              cldfip1=cldfip1+ctemp*cldfip !  maximum overlap levels within a cloud block
              ctest(nc2)=.false.
              ctemp=camt(ip,nc2+1)
            end do
            cldfip1=cldfip1+1.-ctemp ! add clear sky transmission
            nc=nc1+1
            tempc(:,:)=tempc(:,:)*cldfip1(:,:) ! random overlap between cloud blocks
          end do
          cldfac(ip,:,:)=tempc(:,:)
        end do

      else ! usual
      
       do ip=1,imax
         if (nclds(ip).eq.0) then
           tempc(:,:)=1.      ! MJT bug fix
         endif
         if (nclds(ip).ge.1) then
            xcld=1.-camt(ip,2)*emcld(ip,2)
            k1=ktop(ip,2)+1
            k2=kbtm(ip,2)
            cldfip(:,:)=1. ! MJT bug fix
            do k=k1,lp1
            do kp=1,k2
               cldfip(kp,k)=xcld
            enddo
            enddo
            do k=1,k2
            do kp=k1,lp1
               cldfip(kp,k)=xcld
            enddo
            enddo
            tempc(:,:)=cldfip(:,:) ! MJT bug fix
         endif
         if (nclds(ip).ge.2) then
            do nc=2,nclds(ip)
               xcld=1.-camt(ip,nc+1)*emcld(ip,nc+1)
               k1=ktop(ip,nc+1)+1
               k2=kbtm(ip,nc+1)
               cldfip(:,:)=1.  ! MJT bug fix
               do k=k1,lp1
               do kp=1,k2
                  cldfip(kp,k)=xcld
               enddo
               enddo
               do k=1,k2
               do kp=k1,lp1
                  cldfip(kp,k)=xcld
               enddo
               enddo
               tempc(:,:)=tempc(:,:)*cldfip(:,:) ! MJT bug fix
            enddo
         endif
         cldfac(ip,:,:)=tempc(:,:) ! MJT bug fix
       enddo

      end if ! nmr.ne.2
      return
      end 
