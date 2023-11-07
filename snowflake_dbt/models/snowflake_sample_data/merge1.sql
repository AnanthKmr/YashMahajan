


with joins as(
    select s.stdid,a.stdname,a.marks,s.TEACHERNAME,s.TEACHERID
    from {{ ref ('src_std') }} a 
    join {{ ref ('src_teach') }} s
    on s.stdid=a.stdid
)

select * from joins