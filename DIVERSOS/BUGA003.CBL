       ID                              DIVISION.                        00112009
       PROGRAM-ID.                     BUGA003.                         00113011
       ENVIRONMENT                     DIVISION.                        00117001
       CONFIGURATION                   SECTION.                         00118001
       SPECIAL-NAMES.                  DECIMAL-POINT IS COMMA           00119111
           CURRENCY SIGN IS 'BRL' WITH PICTURE SYMBOL '$'.              00119211
       INPUT-OUTPUT                    SECTION.                         00119401
       DATA                            DIVISION.                        00119701
       WORKING-STORAGE                 SECTION.                         00120001
       77  HELLO-WORLD                 PIC  X(11) VALUE 'HELLO WORLD'.  00120410
       77  DOIS                        PIC  X(30) VALUE ALL '2'.        00120511
       77 A1 PIC S9(4) VALUE 20.                                        00120611
       01 A2 PIC S9(4)V99 VALUE 0.                                      00120711
       01 A4 REDEFINES A2 PIC 9(6).                                     00120811
       77 A3 PIC S9(6)    VALUE 0.                                      00120911
       01 OITO PIC 9(6)V99 VALUE IS  123456,78 .                        00121011
       01 SEIS PIC 9(2)V9999 VALUE IS ZEROES.                           00121111
       77 LINDAO PIC $ZZ.ZZZ.ZZ9,99.                                    00121211
       77 DTINREL        PIC S9(6)  COMP-3 VALUE +180510.               00121312
       77  NUMERICO-DE-6            PIC 9(6) VALUE ZEROES.              00121412
       01 GUARDA-01.                                                    00121512
      *                                                                 00121712
      * Data do processamento                                           00121812
      *                                                                 00121912
           03  WDATAANT-SYS011    PIC X(6) VALUE 'AAMMDD'.              00122012
      *                                                                 00122112
           03  DAT-PSST-SYS011    VALUE '20AAMMDD'.                     00122212
               05 ANO.                                                  00122312
                  07              PIC 99.                               00122412
                  07 AA           PIC XX.                               00122512
               05 MES             PIC XX.                               00122612
               05 DIA             PIC XX.                               00122712
           66  GDA-DATA-AAMMDD-SYS011 RENAMES AA THRU DIA.              00122812
       77 grande pic x(50) value all '#'.                               00122913
       01 soc7 pic x(8) value zeroes.                                   00123014
       01 numero redefines soc7 pic s9(15) comp-3.                      00123114
      *                                                                 00124011
       PROCEDURE                       DIVISION.                        00272101
      *                                                                 00272601
           display grande                                               00272713
           move spaces to grande(30:)                                   00272813
           display grande                                               00272913
           display soc7                                                 00273014
           move all "#" to soc7                                         00273114
           display soc7                                                 00273214
           if numero is not equal to zeroes then                        00273314
              display 'nao é zero, mas abendou ?'                       00273414
           end-if                                                       00273514
      *     goback.                                                      00273613
      *******************                                               00273713
           DISPLAY DTINREL                                              00273812
           MOVE DTINREL TO  NUMERICO-DE-6                               00273912
           DISPLAY NUMERICO-DE-6                                        00274012
           MOVE NUMERICO-DE-6          TO GDA-DATA-AAMMDD-SYS011        00274112
           DISPLAY GDA-DATA-AAMMDD-SYS011                               00274212
           MOVE GDA-DATA-AAMMDD-SYS011 TO WDATAANT-SYS011               00274312
           DISPLAY WDATAANT-SYS011                                      00274412
      *     GOBACK.                                                      00274512
      ******                                                            00274612
           DISPLAY HELLO-WORLD                                          00274710
           MOVE '2' TO HELLO-WORLD                                      00274811
           DISPLAY HELLO-WORLD                                          00274911
           DISPLAY DOIS                                                 00275011
           MOVE HELLO-WORLD TO DOIS                                     00275111
           DISPLAY DOIS                                                 00275211
           DISPLAY  '---------------------------------------------'     00275311
           DISPLAY OITO                                                 00275411
           DISPLAY SEIS                                                 00275511
           MOVE OITO TO SEIS                                            00275611
           DISPLAY SEIS                                                 00275711
           MOVE SEIS TO LINDAO                                          00275811
           DISPLAY LINDAO                                               00275911
           DISPLAY  '---------------------------------------------'     00276011
           DISPLAY A1 '-' A2 '-' A3                                     00276111
           MOVE A1 TO A2                                                00276211
           DISPLAY A2                                                   00276311
           ADD 1 TO A4                                                  00276411
           DISPLAY A4                                                   00276511
           DISPLAY A2                                                   00276611
           MOVE A2 TO A3                                                00276711
           DISPLAY A3                                                   00276811
           GOBACK.                                                      00276911