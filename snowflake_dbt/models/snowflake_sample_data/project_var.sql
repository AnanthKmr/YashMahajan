

with dpt_model as(
    select 
        empid,
        deptname,
        iff(dept.deptname = '{{ var ("condition")}}',1,2) as check1
    from dept
)

select * from dpt_model


