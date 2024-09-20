declare
cursor emp is (select emp_id from hr_employees he 
where HE.RESIGN_DATE is null
and HE.DOJ is not null
and not exists (select emp_id from hr_attendances ha where he.emp_id = ha.emp_id 
and ATTENDANCE_DATE between '01-oct-2012' and '31-oct-2012'));
begin
for i in emp  loop      
    INSERT INTO hr_attendances
    (attendance_id, attendance_date, emp_id, attendance_status,
    shift_id, shift_start_time, shift_end_time,late_time, posted, created_by,
    creation_date, last_updated_by, last_update_date)
    SELECT hr_attendance_id_s.NEXTVAL, hrgs.rouster_date, he.emp_id,
    DECODE (SUBSTR (TO_CHAR (hrgs.rouster_date, 'DAY'), 1, 3),
    upper(he.restday1), 'R', upper(he.restday2), 'R',
    'A'
    ),
    hrgs.shift_id,
    TO_DATE (   TO_CHAR (hrgs.rouster_date, 'dd-mon-yyyy')
    || TO_CHAR (hs.shift_start_time, ' HH24:MI'),
    'dd-mon-yyyy HH24:MI'
    ),
    TO_DATE (   TO_CHAR (hrgs.rouster_date, 'dd-mon-yyyy')
    || TO_CHAR (hs.shift_end_time, ' HH24:MI'),
    'dd-mon-yyyy HH24:MI'
    ),
    TO_DATE (   TO_CHAR (hrgs.rouster_date, 'dd-mon-yyyy')
    || TO_CHAR (hs.mark_late_after, ' HH24:MI'),
    'dd-mon-yyyy HH24:MI'
    ),
    'N', 1, SYSDATE, 1, SYSDATE
    FROM hr_employees he, hr_shifts hs, hr_rouster_group_schedules hrgs
    WHERE hrgs.shift_id = hs.shift_id
    AND hrgs.period_id = '201304'
    AND he.emp_group = hrgs.GROUP_ID
    AND he.resign_date IS NULL
    and he.doj is not null
    and HRGS.ROUSTER_DATE>=he.doj    
    AND TO_CHAR(hs.shift_start_time,'HH24:MI')<TO_CHAR(hs.shift_end_time,'HH24:MI')
    and HE.EMP_ID = i.emp_id;

    INSERT INTO hr_attendances
    (attendance_id, attendance_date, emp_id, attendance_status,
    shift_id, shift_start_time, shift_end_time,late_time, posted, created_by,
    creation_date, last_updated_by, last_update_date)
    SELECT hr_attendance_id_s.NEXTVAL, hrgs.rouster_date, he.emp_id,
    DECODE (SUBSTR (TO_CHAR (hrgs.rouster_date, 'DAY'), 1, 3),
    upper(he.restday1), 'R', upper(he.restday2), 'R',
    'A'
    ),
    hrgs.shift_id,
    TO_DATE (   TO_CHAR (hrgs.rouster_date, 'dd-mon-yyyy')
    || TO_CHAR (hs.shift_start_time, ' HH24:MI'),
    'dd-mon-yyyy HH24:MI'
    ),
    TO_DATE (   TO_CHAR (hrgs.rouster_date, 'dd-mon-yyyy')
    || TO_CHAR (hs.shift_end_time, ' HH24:MI'),
    'dd-mon-yyyy HH24:MI'
    )+1,
    TO_DATE (   TO_CHAR (hrgs.rouster_date, 'dd-mon-yyyy')
    || TO_CHAR (hs.mark_late_after, ' HH24:MI'),
    'dd-mon-yyyy HH24:MI'
    ),             
    'N', 1, SYSDATE, 1, SYSDATE
    FROM hr_employees he, hr_shifts hs, hr_rouster_group_schedules hrgs
    WHERE hrgs.shift_id = hs.shift_id
    AND hrgs.period_id = '201304'
    AND he.emp_group = hrgs.GROUP_ID
    AND he.resign_date IS NULL
    and he.doj is not null
    and HRGS.ROUSTER_DATE>=he.doj
    AND TO_CHAR(hs.shift_start_time,'HH24:MI')>TO_CHAR(hs.shift_end_time,'HH24:MI')
    and HE.EMP_ID = i.emp_id;
END loop;
end;