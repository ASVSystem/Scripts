
create or replace function hmdcc_obter_saps3_seq(hmdcc_epimed_saps3_seq varchar2)

return number

is

seq_val_w number :=0;

begin

   execute immediate 'select '||hmdcc_epimed_saps3_seq||'.nextval from dual' into seq_val_w;

return seq_val_w;

end;

