--//consulta qual SELECT está causando lock\\--

select /*+ ORDERED USE_NL(st) */ sql_text
  from v$session ses,
       v$sqltext st
  where st.address = ses.sql_address
   and st.hash_value=ses.sql_hash_value
   and ses.sid= '465'
order by piece;


