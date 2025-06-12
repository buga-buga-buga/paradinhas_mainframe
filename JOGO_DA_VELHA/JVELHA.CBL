      *****  LAYOUT PADRAO  *******************************************
      *---------------------------------------------------------------*
       IDENTIFICATION DIVISION.
      *---------------------------------------------------------------*
       PROGRAM-ID.                     JVELHA.
       AUTHOR.                         ANONIMO  HUM.
       DATE-WRITTEN.                   27/03/2015.
      *---------------------------------------------------------------*
       REMARKS.
      *---------------------------------------------------------------*
      * OBJETIVO:                                                     *
      *     GRAVAR REGISTRO TIPO HEADER, DETALHE E TRAILLER DO AQUIVO *
      *     BHVA1603                                                  *
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       ENVIRONMENT DIVISION.
      *SEGUNDA SEÇÃO DO PROGRAMA, QUE ESTÁ DIVIDO EM DUAS SECTIONS.
      *CONFIGURATION E INPUT-OUTPUT
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       CONFIGURATION SECTION.
      *DESCREVEMOS INSFORMAÇÕES DO COMPUTADOR
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       INPUT-OUTPUT SECTION.
      *DESCREVEMOS INFORMAÇÕES DOS ARQUIVOS
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       FILE-CONTROL.
      *DEFINIMOS OS SELECTS.

      *EX
      *---MODELO SEQUENCIAL
      *SELECT CADALUNO ASSIGN TO CADALUNO
      *    FILE STATUS IS WS-FS-CADALUNO

      *---MODELO VSAM
      *SELECT CADCURSO ASSIGN TO CADCURSO
      *    ACCESS DYNAMIC
      *    ORGANIZATION INDEXED
      *    RECORD KEY CADCURSO-CDCURSO
      *    STATUS OS WS-FS-CADCURSO
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       DATA DIVISION.
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       FILE SECTION.

      *FD CADCURSO.
      *01 REG-CADCURSO.
      *    03 CADCURSO-CDCURSO     PIC 9(05).
      *    03 CADCURSO-NOME        PIC X(40).
      *    03 FILLER               PIC X(55).
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       WORKING-STORAGE SECTION.
      *-- AUXILIARES --
      *01 WS-BHVC990-DT-ANTERIOR       PIC 9(08) VALUE ZEROS.
       01 PLAYERS.
           03 PLAYER01                     PIC X(15) VALUE SPACES.
           03 PLAYER02                     PIC X(15) VALUE SPACES.
           03 PONTOP01                     PIC 9(02) VALUE ZEROS.
           03 PONTOP02                     PIC 9(02) VALUE ZEROS.
           03 EMPATE                       PIC 9(02) VALUE ZEROS.
           03 WINNER                       PIC X(15) VALUE SPACES.
           03 NJOGADA                      PIC 9(02) VALUE ZEROS.
           03 JG                           PIC X(02) VALUE ' '.
           03 TIRO                         PIC X(01) VALUE ' '.

       01 CASAS.
           03 A1                           PIC X(01) VALUE ' '.
           03 A2                           PIC X(01) VALUE ' '.
           03 A3                           PIC X(01) VALUE ' '.

           03 B1                           PIC X(01) VALUE ' '.
           03 B2                           PIC X(01) VALUE ' '.
           03 B3                           PIC X(01) VALUE ' '.

           03 C1                           PIC X(01) VALUE ' '.
           03 C2                           PIC X(01) VALUE ' '.
           03 C3                           PIC X(01) VALUE ' '.

       01 WS-FIM                           PIC X(01) VALUE 'N'.
       01 WS-JOGAR                         PIC X(01) VALUE SPACES.
      *-- FILE STATUS --
      *01 WS-FS-BHVA1603               PIC X(02) VALUE '00'.

      *-- ACUMULADORES --
      *01 TOTALIZADORES.
      *    03 WS-LIDOS-BHVA990         PIC 9(09) VALUE ZEROS.
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
      *BOOK PARA ROTINA ABENDS                                        *
      *---------------------------------------------------------------*
       PROCEDURE DIVISION.

       00000-INICIO    SECTION.
           PERFORM 10000-INICIALIZAR.
           PERFORM 20000-PROCESSAR UNTIL WS-FIM EQUAL 'S'.
      *    PERFORM 20000-PROCESSAR.
           PERFORM 30000-FINALIZAR.
       00000-99-EXIT.  EXIT.
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       10000-INICIALIZAR   SECTION.
      *    PERFORM FINALIZACAO.
           DISPLAY ' '                                     UPON CONSOLE.
           DISPLAY '**************************************'UPON CONSOLE.
           DISPLAY '******    INTRUÇÕES     **************'UPON CONSOLE.
           DISPLAY '**************************************'UPON CONSOLE.
           DISPLAY 'UTILIZE UMA LETRA A | B | C PARA UM  ' UPON CONSOLE.
           DISPLAY 'COMANDO HORIZONTAL E 1 | 2 | 3 PARA '  UPON CONSOLE.
           DISPLAY 'UM COMANDO VERTICAL...'                UPON CONSOLE.
           DISPLAY 'EX: A3 PARA JOGAR NA PRIMEIRA CASA'    UPON CONSOLE.
           DISPLAY 'DA ULTIMA FILEIRA'                     UPON CONSOLE.

           DISPLAY '**************************************'UPON CONSOLE.
           DISPLAY '      BOA SORTE!!!              '      UPON CONSOLE.
           DISPLAY '**************************************'UPON CONSOLE.
           DISPLAY ' '                                     UPON CONSOLE.


           DISPLAY 'INFORME O NOME DO JOGADOR X: ' UPON CONSOLE.
           ACCEPT PLAYER01                         FROM CONSOLE.
           DISPLAY ' '                             UPON CONSOLE.


           DISPLAY 'INFORME O NOME DO JOGADOR O: ' UPON CONSOLE.
           ACCEPT PLAYER02                         FROM CONSOLE.
           DISPLAY ' '                             UPON CONSOLE.

           DISPLAY PLAYER01 ' VS ' PLAYER02        UPON CONSOLE.
           DISPLAY ' '                             UPON CONSOLE.

       COMECAR.
           PERFORM TELA.

           PERFORM 20000-PROCESSAR.
       10000-99-EXIT.  EXIT.
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       20000-PROCESSAR   SECTION.

           ADD 1 TO NJOGADA
           DISPLAY 'JOGADA: ' NJOGADA                      UPON CONSOLE.
           DISPLAY 'X - 'PLAYER01 ' INFORME A JOGADA: '    UPON CONSOLE.
      *    ACCEPT JG                               FROM CONSOLE.
           MOVE 'X' TO TIRO.
           PERFORM JOGADA.
           PERFORM TELA.
           PERFORM FINALIZACAO.

           ADD 1 TO NJOGADA
           DISPLAY 'JOGADA: ' NJOGADA                      UPON CONSOLE.
           DISPLAY 'O - 'PLAYER02 ' INFORME A JOGADA: '    UPON CONSOLE.
           MOVE 'O' TO TIRO.
      *    ACCEPT JG                               FROM CONSOLE.
           PERFORM JOGADA.
           PERFORM TELA.
           PERFORM FINALIZACAO.
           GO TO 20000-PROCESSAR.

       20000-PROCESSAR-EXIT.  EXIT.

      *---------------
       TELA SECTION.
           DISPLAY '*****************************' UPON CONSOLE.
           DISPLAY ' '                             UPON CONSOLE.

           DISPLAY       '  A   B   C'             UPON CONSOLE.
           DISPLAY       '    |   |'               UPON CONSOLE.
           DISPLAY       '1 'A1' | 'B1' | 'C1      UPON CONSOLE.
           DISPLAY       ' ___|___|___'            UPON CONSOLE.
           DISPLAY       '    |   |   '            UPON CONSOLE.
           DISPLAY       '2 'A2' | 'B2' | 'C2      UPON CONSOLE.
           DISPLAY       ' ___|___|___'            UPON CONSOLE.
           DISPLAY       '    |   |   '            UPON CONSOLE.
           DISPLAY       '3 'A3' | 'B3' | 'C3      UPON CONSOLE.
           DISPLAY       '    |   |    '           UPON CONSOLE.

           DISPLAY ' '                             UPON CONSOLE.
           DISPLAY ' '                             UPON CONSOLE.
       TELA-FIM.
           EXIT.

      *---------------
       JOGADA SECTION.
           PERFORM DEU-VELHA

           ACCEPT JG                               FROM CONSOLE.
           IF JG EQUAL 'A1' AND A1 EQUAL ' ' OR
              JG EQUAL 'A2' AND A2 EQUAL ' ' OR
              JG EQUAL 'A3' AND A3 EQUAL ' ' OR

              JG EQUAL 'B1' AND B1 EQUAL ' ' OR
              JG EQUAL 'B2' AND B2 EQUAL ' ' OR
              JG EQUAL 'B3' AND B3 EQUAL ' ' OR

              JG EQUAL 'C1' AND C1 EQUAL ' ' OR
              JG EQUAL 'C2' AND C2 EQUAL ' ' OR
              JG EQUAL 'C3' AND C3 EQUAL ' '
      *       ADD 1 TO EMPATE
              PERFORM MOVE-JOGADA
           ELSE
               DISPLAY ' '                                 UPON CONSOLE
               DISPLAY 'CAMPO JÁ UTILIZADO...'             UPON CONSOLE
               DISPLAY 'ESCOLHA UM CAMPO AINDA NÃO UTILIZADO'
                                                           UPON CONSOLE
               DISPLAY ' '                                 UPON CONSOLE
               GO TO TELA
           END-IF.

       JOGADA-FIM.
           EXIT.

      *---------------
       MOVE-JOGADA SECTION.

           EVALUATE JG
               When 'A1'
                   MOVE TIRO TO A1
               When 'B1'
                   MOVE TIRO TO B1
               When 'C1'
                   MOVE TIRO TO C1

               When 'A2'
                   MOVE TIRO TO A2
               When 'B2'
                   MOVE TIRO TO B2
               When 'C2'
                   MOVE TIRO TO C2

               When 'A3'
                   MOVE TIRO TO A3
               When 'B3'
                   MOVE TIRO TO B3
               When 'C3'
                   MOVE TIRO TO C3

               When other
                   Display ' '                             UPON CONSOLE
                   Display 'Erro...'                       UPON CONSOLE
                   Display ' '                             UPON CONSOLE
                   Display 'INFORME UMA OPÇÃO VÁLIDA'      UPON CONSOLE
                   Display ' '                             UPON CONSOLE

                   GO TO 20000-PROCESSAR
           End-evaluate    EXIT.


       MOVE-JOGADA-FIM.
           EXIT.

      *---------------
       DEU-VELHA SECTION.

           IF A1 NOT EQUAL ' ' AND
              A2 NOT EQUAL ' ' AND
              A3 NOT EQUAL ' ' AND

              B1 NOT EQUAL ' ' AND
              B2 NOT EQUAL ' ' AND
              B3 NOT EQUAL ' ' AND

              C1 NOT EQUAL ' ' AND
              C2 NOT EQUAL ' ' AND
              C3 NOT EQUAL ' '

              DISPLAY ' '                                  UPON CONSOLE
              DISPLAY 'EMPATOU...............'             UPON CONSOLE
              DISPLAY ' '                                  UPON CONSOLE
              MOVE ' ' TO TIRO
              PERFORM PLACAR
           END-IF.

       DEU-VELHA-EXIT.
           EXIT.

      *---------------
       FINALIZACAO SECTION.

      *    GO TO DEU-VELHA

           IF TIRO EQUAL A1 AND TIRO EQUAL B1 AND TIRO EQUAL C1 OR
              TIRO EQUAL A2 AND TIRO EQUAL B2 AND TIRO EQUAL C2 OR
              TIRO EQUAL A3 AND TIRO EQUAL B3 AND TIRO EQUAL C3 OR
              TIRO EQUAL A1 AND TIRO EQUAL B2 AND TIRO EQUAL C3 OR
              TIRO EQUAL A1 AND TIRO EQUAL A2 AND TIRO EQUAL A3 OR
              TIRO EQUAL B1 AND TIRO EQUAL B2 AND TIRO EQUAL B3 OR
              TIRO EQUAL C1 AND TIRO EQUAL C2 AND TIRO EQUAL C3 OR
              TIRO EQUAL C1 AND TIRO EQUAL B2 AND TIRO EQUAL A3
               DISPLAY TIRO ' GANHOU'                      UPON CONSOLE
               PERFORM PLACAR
      *        ACCEPT TIRO FROM CONSOLE
      *    GO TO 30000-FINALIZAR
           END-IF.
       FINALIZACAO-FIM.
           EXIT.

      *---------------
       PLACAR SECTION.
           PERFORM VER-GANHADOR
           DISPLAY ' '                                     UPON CONSOLE.
           DISPLAY '******************************'        UPON CONSOLE.
           DISPLAY '*********** PLACAR ***********'        UPON CONSOLE.
           DISPLAY PLAYER01 ' = ' PONTOP01 ' PONTOS '      UPON CONSOLE.
           DISPLAY PLAYER02 ' = ' PONTOP02 ' PONTOS '      UPON CONSOLE.
           DISPLAY 'EMPATE = ' EMPATE                      UPON CONSOLE.
           DISPLAY 'NUMERO DE JOGADAS = ' NJOGADA          UPON CONSOLE.
           DISPLAY '******************************'        UPON CONSOLE.
           DISPLAY ' '                                     UPON CONSOLE.
           DISPLAY 'DESEJA JOGAR NOVAMENTE? '              UPON CONSOLE.
           DISPLAY 'S/N'                                   UPON CONSOLE.
           ACCEPT WS-JOGAR FROM CONSOLE.
           DISPLAY '******************************'        UPON CONSOLE.
           DISPLAY ' '                                     UPON CONSOLE.

           EVALUATE WS-JOGAR
               WHEN 'S'
                   MOVE 0              TO NJOGADA
                   MOVE ' '            TO A1
                   MOVE ' '            TO A2
                   MOVE ' '            TO A3

                   MOVE ' '            TO B1
                   MOVE ' '            TO B2
                   MOVE ' '            TO B3

                   MOVE ' '            TO C1
                   MOVE ' '            TO C2
                   MOVE ' '            TO C3

                   GO TO COMECAR
               WHEN 'N'
                   GO TO 30000-FINALIZAR
               When other
                   DISPLAY 'COMANDO INVÁLIDO'              UPON CONSOLE
                   GO TO PLACAR
           END-EVALUATE.

       PLACAR-FIM.
           EXIT.

      *---------------
       VER-GANHADOR SECTION.

           IF TIRO EQUAL 'X'
               ADD 1 TO PONTOP01
           END-IF.

           IF TIRO EQUAL 'O'
               ADD 1 TO PONTOP02
           END-IF.

           IF TIRO EQUAL ' '
               ADD 1 TO EMPATE
           END-IF.

       VER-GANHADOR-EXIT.
           EXIT.
      *---------------------------------------------------------------*

      *---------------------------------------------------------------*
       30000-FINALIZAR   SECTION.
           STOP RUN.
       30000-FINALIZAR-EXIT.  EXIT.
      *---------------------------------------------------------------*