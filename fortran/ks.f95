program Kiloseconds
    
    integer,dimension(8) :: date
    real :: ks

    call date_and_time(VALUES=date) ! VALUE(5) - hour,
                                    ! VALUE(6) - minutes,
                                    ! VALUE(7) - seconds,
                                    ! VALUE(8) - milliseconds.
    ks = date(5)*3.6 + date(6)*0.06 + date(7)*0.001 + date(8)*10**(-6)

    write(*,'(F6.3, " kiloseconds")'), ks
end program Kiloseconds
