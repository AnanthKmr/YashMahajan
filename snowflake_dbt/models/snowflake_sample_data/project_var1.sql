


with dpt_model as(
    select 
        empid,
        deptname
    from dept
    where dept.deptname = '{{ var ("condition")}}'
)

select * from dpt_model

