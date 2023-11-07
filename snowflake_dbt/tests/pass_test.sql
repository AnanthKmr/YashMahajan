

select stdid 
from {{ref ('src_std')}}
where marks < 35