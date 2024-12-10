! file to sum result of sumxen
! Make sure types for EN, CS in read statement align with file 
program sum_sumxen
    implicit none
    integer :: i, iostat
    real(8) :: EN, CS
    character(len=100) :: line
    real(8), dimension(100) :: energies  ! Array to hold unique EN values
    real(8), dimension(100) :: crosssections    ! Array to hold summed CS values
    integer :: count
    logical :: found
    logical :: skip
    character(len=30) :: keyword, ampersand
 
    ! Initialize counter
    count = 0
    
    ! Set up to skip lines that contain @legend
   
    keyword = '@legend'
    ampersand = '&'   

    ! Read data
    do while (.true.)
	read(*, '(A)', iostat=iostat) line   ! Read in as a string 
	if (iostat /= 0) exit 
        skip = .false.                       ! set up to not skip right away

	! Search the line for the keyword. 0 means it is not in the line, 1 does. So skip if 1.
	if ((index(line, keyword) > 0) .or. (index(line, ampersand) > 0)) then 
		skip = .true.
	end if

	if (skip) cycle 
    
	! Read EN and CS data, 
        read(line, '(f5.3, f3.1)', iostat=iostat) EN, CS
	if (iostat /= 0) then
            print *, "Error reading values from line."
	    cycle
	else
            print *, 'Energy (EN):', EN
	    print *, 'Cross-section (CS):', CS
	end if

        ! Start with assumption energy is not in the list of energies. 
        ! This will add each energy to the list when first encountered
	found = .false.

	! Check if EN is in the list, add the cross-section to corresponding values
        do i = 1, count
            if (energies(i) == EN) then                   ! Check if the value for EN is already in energies
                crosssections(i) = crosssections(i) + CS  ! if EN is in energies already, add to cross sections
                found = .true.				  ! flag necessary to skip the next loop 
                exit
            end if
        end do

        ! If EN doesn't alread exist, add to energy list
        if (.not. found) then
            count = count + 1
            energies(count) = EN
            crosssections(count) = CS
        end if
    end do

    ! output the results
    print *
    do i = 1, count
        print *, energies(i), crosssections(i)
    end do
end program sum_sumxen
