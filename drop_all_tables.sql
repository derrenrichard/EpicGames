SET SERVEROUTPUT ON SIZE 1000000;
SET FEEDBACK OFF;

DECLARE
    CURSOR c_tables IS
        SELECT table_name
        FROM user_tables
        WHERE dropped = 'NO' -- Exclude tables in the recycle bin
        ORDER BY table_name DESC; -- Drop dependent tables first if possible (though CASCADE is safer)
    v_drop_stmt VARCHAR2(4000);
BEGIN
    FOR t_rec IN c_tables LOOP
        BEGIN
            v_drop_stmt := 'DROP TABLE ' || t_rec.table_name || ' CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Executing: ' || v_drop_stmt);
            EXECUTE IMMEDIATE v_drop_stmt;
            DBMS_OUTPUT.PUT_LINE(t_rec.table_name || ' dropped successfully.');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error dropping ' || t_rec.table_name || ': ' || SQLERRM);
                -- Optionally, you can log this error or re-raise it
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('All accessible tables attempted to be dropped.');
END;
/

SET FEEDBACK ON;
SET SERVEROUTPUT OFF;
