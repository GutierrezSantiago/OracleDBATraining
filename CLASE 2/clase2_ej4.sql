SET SERVEROUT ON

BEGIN

    FOR I IN 1..10 LOOP
    
        IF I != 7 THEN
            DBMS_OUTPUT.PUT_LINE (I);
        END IF;
    END LOOP;


END;