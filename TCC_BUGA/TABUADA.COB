       IDENTIFICATION DIVISION.
       PROGRAM-ID. TABUADA.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 N PIC 9(2).
       01 I PIC 9(2).
       01 R PIC 9(4).
       PROCEDURE DIVISION.
           DISPLAY "DIGITE UM NUMERO: "
           ACCEPT N
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
               MULTIPLY N BY I GIVING R
               DISPLAY N " X " I " = " R
           END-PERFORM
           STOP RUN.