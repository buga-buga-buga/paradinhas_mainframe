       ID                              DIVISION.
       PROGRAM-ID.                     SAMPLE.
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       DATA                            DIVISION.
       WORKING-STORAGE                 SECTION.
       01  BOLUDO                      PIC  X(08) VALUE 'BOLUDO'.
       01  FILLER.
           05  WS-MESSAGE-TYPE          PIC X(08) VALUE SPACES.
           05  WS-MESSAGE               PIC X(40) VALUE SPACES.
      *----------------------------------------------------------------*
       PROCEDURE                       DIVISION.
      *----------------------------------------------------------------*
      *    ROTINA PRINCIPAL                                            *
      *----------------------------------------------------------------*
       RT-PRINCIPAL                    SECTION.
      *
           DISPLAY 'BOLUDO03'
      *
           GOBACK.
      *
       RT-PRINCIPALX.                  EXIT.




       2000-SPEAK.

           IF WS-MESSAGE-TYPE IS EQUAL TO 'GREETING'
               MOVE 'HELLO, WORLD!' TO WS-MESSAGE
           END-IF

           IF WS-MESSAGE-TYPE IS EQUAL TO 'FAREWELL'
               MOVE 'SEE YOU LATER, ALLIGATOR!' TO WS-MESSAGE
           END-IF

           IF WS-MESSAGE-TYPE IS EQUAL TO 'ROLA' THEN
               MOVE 'ROLA' TO WS-MESSAGE
           END-IF
           .

       9999-END.
           .

