


with joins as(
    select s.empid,a.empname,a.sal,s.deptname,s.deptid,s.src_updated_datetime2,a.src_updated_datetime1
    from {{ ref ('source_dept') }} s 
    join {{ ref ('source_insert1') }} a 
    on s.empid=a.empid
)

select * from joins