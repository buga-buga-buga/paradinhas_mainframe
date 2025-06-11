       IDENTIFICATION DIVISION.
       PROGRAM-ID. T4BU4D4.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 A1 PIC 9(2).
       01 B2 PIC 9(2).
       01 C3 PIC 9(4).
       01 D4 PIC X(1) VALUE X'20'.
       01 E5 PIC X(1) VALUE X'58'.
       01 F6 PIC X(3) VALUE X'3D20'.
       PROCEDURE DIVISION.
           DISPLAY "DIGITE UM NUMERO:" D4
           ACCEPT A1
           MOVE 1 TO B2
           PERFORM UNTIL B2 > 10
               MULTIPLY A1 BY B2 GIVING C3
               DISPLAY A1 D4 E5 D4 B2 D4 F6 C3
               ADD 1 TO B2
           END-PERFORM
           STOP RUN.