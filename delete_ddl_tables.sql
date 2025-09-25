-- WARNING: This script will permanently delete the specified tables and their data.
-- Ensure you are connected to the correct schema (e.g., game_app_user)
-- and have a backup if the data is valuable.

SET SERVEROUTPUT ON;
SET FEEDBACK OFF;

BEGIN
    -- Drop tables that have foreign keys pointing to others first (child tables),
    -- or use CASCADE CONSTRAINTS which handles dependencies.
    -- I'm ordering them from child to parent based on the ERD for clarity,
    -- but CASCADE CONSTRAINTS makes the specific order less critical for successful dropping.

    DBMS_OUTPUT.PUT_LINE('Attempting to drop specified tables...');

    -- gamereviews depends on users and games
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE gamereviews CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table gamereviews dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping gamereviews: ' || SQLERRM); END;

    -- purchases depends on users and games
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE purchases CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table purchases dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping purchases: ' || SQLERRM); END;

    -- userlibrary depends on users and games
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE userlibrary CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table userlibrary dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping userlibrary: ' || SQLERRM); END;

    -- games depends on developers and genres
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE games CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table games dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping games: ' || SQLERRM); END;

    -- userachievements depends on users and achievements
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE userachievements CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table userachievements dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping userachievements: ' || SQLERRM); END;

    -- customers depends on users
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE customers CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table customers dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping customers: ' || SQLERRM); END;

    -- developers depends on users
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE developers CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table developers dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping developers: ' || SQLERRM); END;

    -- The remaining tables have no outgoing foreign keys to other tables in this set
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE gameservers CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table gameservers dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping gameservers: ' || SQLERRM); END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE genres CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table genres dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping genres: ' || SQLERRM); END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE achievements CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table achievements dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping achievements: ' || SQLERRM); END;

    -- users should be dropped last as many tables depend on it (customers, developers, userachievements)
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table users dropped successfully.');
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error dropping users: ' || SQLERRM); END;

    DBMS_OUTPUT.PUT_LINE('Finished attempting to drop specified tables.');
END;
/

SET FEEDBACK ON;
SET SERVEROUTPUT OFF;
