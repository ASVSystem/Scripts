select h.session_id Sessao_Travadora, ub.username Usuario_Travador ,w.session_id Sessao_Esperando, uw.username Usuario_Esperando,
w.lock_type,
h.mode_held,
w.mode_requested,
w.lock_id1,
w.lock_id2
from dba_locks w, dba_locks h, v$session ub, v$session uw
where h.blocking_others = 'Blocking'
and h.mode_held!= 'None'
and h.mode_held!= 'Null'
and h.session_id = ub.sid
and w.mode_requested != 'None'
and w.lock_type = h.lock_type
and w.lock_id1 = h.lock_id1
and w.lock_id2 = h.lock_id2
and w.session_id = uw.sid;