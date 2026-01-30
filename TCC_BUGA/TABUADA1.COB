      * ----------------------------------------------------------------
       ID DIVISION.                                                     
       PROGRAM-ID. TABUADA.                                             
       DATA DIVISION.                                                   
      *                                                                 
      * -------------------------                                       
       WORKING-STORAGE SECTION.                                         
      * -------------------------                                       
      *                                                                 
      *                                                                 
       01 DADO-DE-ENTRADA                    PIC ZZ9.                   
       01 LIMPA REDEFINES DADO-DE-ENTRADA    PIC XXX.                   
      *                                                                 
       01 TABELA.                                                       
           03 RESULTADO OCCURS 999 TIMES DEPENDING ON LIMITE            
                                             PIC S9(8) COMP VALUE 0.    
      *                                                                 
       01 NUMERO-DA-TABUADA                  PIC S9(8) COMP VALUE 1.    
      *                                                                 
       01 I                                  PIC S9(8) COMP VALUE 0.    
      *                                                                 
       01 EXIBIR-TABUADA-ATE                 PIC ZZ9.                   
      *                                                                 
       01 LIMITE                             PIC S9(8) COMP VALUE 0.    
      *                                                                 
       01 MENSAGEM                           PIC X(79) VALUE SPACES.    
       01 MASCARA-EXIBICAO1                  PIC ZZ9.                   
       01 MASCARA-EXIBICAO2                  PIC ZZ9.                   
       01 MASCARA-EXIBICAO3                  PIC ZZZZZ9.                
       01 MASCARA-EXIBICAO4                  PIC XXX.                   
      *                                                                 
      *---------------------------------------------------------------- 
       PROCEDURE DIVISION.                                              
      *---------------------------------------------------------------- 
      *                                                                 
      *    Emite mensagem informativa do programa                       
      *                                                                 
           DISPLAY '-------------------------------'                    
           DISPLAY 'PROGRAMA DE EXIBICAO DE TABUADA'                    
           DISPLAY '-------------------------------'                    
      *                                                                 
      *    Recebe do usuario qual o numero que ele quer que seja        
      * exibida a tabuada.                                              
      *                                                                 
           MOVE 'Tabuada de qual numero ? (001-999)'                    
                                                TO MENSAGEM             
           PERFORM RECEBE-DADOS-USUARIO                                 
           MOVE DADO-DE-ENTRADA TO NUMERO-DA-TABUADA                    
           DISPLAY ' '                                                  
      *                                                                 
      *    Solicita que o usuario informe o limite de exibição.         
      *                                                                 
           STRING 'Exibir até ' DADO-DE-ENTRADA ' X quanto ? '          
                  DELIMITED BY SIZE INTO MENSAGEM END-STRING            
           MOVE SPACES TO LIMPA                                         
           PERFORM RECEBE-DADOS-USUARIO                                 
           MOVE DADO-DE-ENTRADA TO LIMITE                               
           DISPLAY ' '                                                  
      *                                                                 
      *    Emite mensagem informando que aquela é a tabuada do numero   
      * informado pelo usuário                                          
      *                                                                 
           MOVE NUMERO-DA-TABUADA    TO MASCARA-EXIBICAO1               
           DISPLAY 'Tabuada do numero ' MASCARA-EXIBICAO1               
      *                                                                 
      *    Estrutura em loop para calcular e exibir a tabuada           
      *                                                                 
           PERFORM WITH TEST AFTER                                      
                VARYING I FROM 1 BY 1                                   
                UNTIL I = LIMITE                                        
                MULTIPLY I BY NUMERO-DA-TABUADA GIVING RESULTADO (I)    
                         ON SIZE ERROR                                  
                            DISPLAY 'Erro durante a realizacao dos '    
                                    'calculos, OVERFLOW.'               
                         STOP RUN                                       
                END-MULTIPLY                                            
      *                                                                 
                MOVE I                 TO MASCARA-EXIBICAO1             
                MOVE NUMERO-DA-TABUADA TO MASCARA-EXIBICAO2             
                MOVE RESULTADO (I)     TO MASCARA-EXIBICAO3             
      *                                                                 
                DISPLAY       MASCARA-EXIBICAO1                         
                        ' X ' MASCARA-EXIBICAO2                         
                        ' = ' MASCARA-EXIBICAO3                         
           END-PERFORM.                                                 
      *                                                                 
      *    Emite rodapé ao final da exibição.                           
      *                                                                 
           DISPLAY '-------------------------------'                    
      *                                                                 
      *    Encerrra a execucao.                                         
      *                                                                 
           STOP RUN.                                                    
                                                                        
           EXIT PROGRAM.                                                
      *                                                                 
      * ----------------------------------------------------------------
       RECEBE-DADOS-USUARIO SECTION.                                    
      * ----------------------------------------------------------------
      *                                                                 
      *    Nessa section recebemos a Input (entrada) do usuário         
      *                                                                 
           PERFORM UNTIL DADO-DE-ENTRADA IS NUMERIC OR                  
                         DADO-DE-ENTRADA = 'SAI'                        
      *                                                                 
      *    Emite mensagem para o usuário solicitando ação.              
      *                                                                 
               DISPLAY MENSAGEM                                         
      *                                                                 
      *    Recebe os dados digitados                                    
      *                                                                 
               ACCEPT DADO-DE-ENTRADA                                   
      *                                                                 
      *    Caso não estejam conforme o esperado, avise e solicite       
      *    reentrada dos dados                                          
      *                                                                 
               IF  DADO-DE-ENTRADA IS NOT NUMERIC OR                    
                   DADO-DE-ENTRADA IS EQUAL TO ZEROES THEN              
                   IF  DADO-DE-ENTRADA = 'SAI'                          
                       DISPLAY 'Saida solicitada '                      
                       STOP RUN                                         
                   END-IF                                               
                   MOVE LIMPA TO MASCARA-EXIBICAO4                      
                   DISPLAY 'Valor informado ' MASCARA-EXIBICAO4         
                           ' eh invalido.'                              
                   DISPLAY 'Informe inclusive com zeros aa esquerda '   
                           'ou digite SAI para encerrar.'               
               END-IF                                                   
           END-PERFORM.                                                 
      *                                                                 
       RECEBE-DADOS-FIM.                                                
           EXIT.                                                        
      *                                                                 
       END PROGRAM TABUADA.                                             
      * ----------------------------------------------------------------
