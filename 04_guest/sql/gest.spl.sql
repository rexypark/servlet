CREATE TABLE GUEST(
	SABUN NUMBER PRIMARY KEY;
	NAME VARCHAR2(30);
	NALJA DATE;
	PAY NUMBER;
);

INSERT INTO GUEST VALUES (1111, 'USER1', SYSDATE-2, 10000)
INSERT INTO GUEST VALUES (2222, 'USER2', SYSDATE-1, 10000)
COMMIT;

SELECT * FROM GUEST;