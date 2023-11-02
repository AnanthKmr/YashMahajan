


with joins as(
    select s.empid,empname,sal,deptname,deptid
    from ref {{'source_dept'}} as s 
    join ref {{'source_insert1'}} as a 
    on s.empid=a.empid
)

select * from joins