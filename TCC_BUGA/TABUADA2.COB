      * ----------------------------------------------------------------
       ID DIVISION.                                                     
       PROGRAM-ID. TABUADA.                                             
       DATA DIVISION.                                                   
       WORKING-STORAGE SECTION.                                         
       01 N-CONFIGURATIO-SECTION.                                       
          03 A PIC X(79). 03 P PIC S9(8) COMP VALUE 0. 03 C PIC S9(8)   
             BINARY VALUE 1. 03 G PIC ZZ9. 03 O PIC 9 VALUE 1. 03 H     
             PIC ZZ9. 03 K PIC ZZZZZ9. 03 J PIC ZZ9. 03 L PIC XXX. 03   
             D PIC S9(8) COMP-5 VALUE 0. 03 N PIC 9 VALUE 1. 03 E PIC   
             ZZ9. 03 F REDEFINES E PIC XXX. 03 . 05 B OCCURS 999 TIMES  
             DEPENDING ON D PIC S9(8) COMP VALUE 0.                     
      *                                                                 
       PROCEDURE DIVISION.                                              
      *                                                                 
           DISPLAY '-------------------------------' DISPLAY 'PROGRAMA D
      -    'E EXIBICAO DE TABUADA' DISPLAY '----------------------------
      -    '---' MOVE 'Tabuada de qual numero ? (001-999)' TO A PERFORM 
           M MOVE E TO C DISPLAY ' ' STRING 'Exibir ate ' E ' X quanto '
           '? ' DELIMITED BY SIZE INTO A MOVE SPACES TO F PERFORM M MOVE
           E TO D DISPLAY ' ' MOVE C TO H DISPLAY 'Tabuada do numero ' A
      -    DD 1 TO D   PERFORM VARYING P FROM N BY O UNTIL P = D MULTIPL
      -    Y P BY C GIVING B (P) ON SIZE ERROR DISPLAY 'Erro durante a r
      -    'realizacao dos calculos, OVERFLOW.' STOP RUN NOT ON SIZE    
           ERROR CONTINUE END-MULTIPLY MOVE P TO H MOVE C TO J  MOVE B (
           P) TO K DISPLAY H ' X ' J ' = ' K END-PERFORM DISPLAY '------
      -    '-------------------------' STOP RUN. EXIT PROGRAM.          
       M.  PERFORM UNTIL E IS NUMERIC OR E = 'SAI' DISPLAY A ACCEPT E IF
           E NOT NUMERIC OR E = 0 IF  E = 'SAI' DISPLAY 'Saida solicitad
      -    'a' STOP RUN ELSE CONTINUE END-IF MOVE F TO L DISPLAY 'Valor'
           ' informado ' L ' eh invalido.' DISPLAY 'Informe inclusive co
      -    'om zeros aa esquerda ou digite SAI para encerrar.' END-IF   
           END-PERFORM.                                                 
      * ----------------------------------------------------------------
