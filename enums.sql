SET SERVEROUTPUT ON;

declare
    roadworthy constant number(1):=1;
    in_for_service constant number(1):=3;
    written_off constant number(1):=2;
     
    subtype car_status is binary_integer range 1..3;
   
    pv_var car_status;
   
    begin
        pv_var:=roadworthy;
        if (pv_var=written_off) then
            dbms_output.put_line('written_off');
        elsif(pv_var=roadworthy) then
            dbms_output.put_line('roadworthy');
        elsif(pv_var=in_for_service) then
            dbms_output.put_line('in_for_service');
        else
            dbms_output.put_line('unknown');
        end if;
    end;
/

declare
    roadworthy constant number(1):=1;
    in_for_service constant number(1):=3;
    written_off constant number(1):=2;
     
    subtype car_status is binary_integer range 1..3;
   
    pv_var car_status;
   
    begin
        pv_var:=roadworthy;
        if (pv_var=written_off) then
            dbms_output.put_line('written_off');
        elsif(pv_var=roadworthy) then
            dbms_output.put_line('roadworthy');
        elsif(pv_var=in_for_service) then
            dbms_output.put_line('in_for_service');
        else
            dbms_output.put_line('unknown');
        end if;
    end;
/