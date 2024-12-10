! file to sum result of sumxen 
program sum_sumxen
    implicit none
    integer :: i, num_headers, iostat
    real :: EN, CS
    character(len=100) :: line
    real, dimension(100) :: EN_values  ! Array to hold unique EN values
    real, dimension(100) :: CS_sums     ! Array to hold summed CS values
    integer :: count

    ! Initialize counter
    count = 0

    ! Step 1: Skip headers
    read(*,*) line 
    read(*,*) line
    read(*,*) line

    ! Read data
    do while (.true.)
	read(*,*) line !skip first header with "bin"
        
	! Read EN and CS
        read(*, '(f8.4, f8.4)', iostat=iostat) EN, CS
        if (iostat /= 0) exit  ! Exit loop if end of file or error

        ! Check if EN is already in the list
        logical :: found
        found = .false.

        do i = 1, count
            if (EN_values(i) == EN) then
                CS_sums(i) = CS_sums(i) + CS  ! Sum CS for the same EN
                found = .true.
                exit
            end if
        end do

        ! If EN new, add it to the list
        if (.not. found) then
            count = count + 1
            EN_values(count) = EN
            CS_sums(count) = CS
        end if
    end do

    ! output the results
    print *, 'Unique EN values and their summed CS:'
    do i = 1, count
        print *, 'EN:', EN_values(i), 'Sum of CS:', CS_sums(i)
    end do
end sum_sumxen
