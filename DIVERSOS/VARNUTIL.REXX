/* REXX */                                                              
/*----------------------------------------------------------------------
                                                                        
 BUGA#001 - prototipo funcional para deteccao de variaveis nao          
 utilizadas                                                             
                                                                        
 VERSAO 0.01 - 20.03.2018 - BUGA
                                                                        
----------------------------------------------------------------------*/
                                                                        
  PROFILE NOPREFIX                                                      
                                                                        
  ARQ_ENT = 'BUGAARQ.FONTES.COBOL(CODE#000)'  /* fonte a ser analisado */ 
                                                                        
 "ALLOC DDN(INFILE) SHR REUSE DSN("ARQ_ENT""                            
 "EXECIO * DISKR INFILE (STEM ENTRADA. FINIS"                           
                                                                        
   CALL ACHA_INI_FIM 'WORKING STORAGE SECTION'                          
   N1 = RESULT                                                          
   CALL ACHA_INI_FIM 'PROCEDURE DIVISION'                               
   N2 = RESULT                                                          
                                                                        
   SAY 'VARIAVEIS PESQUISADAS ENTRE AS LINHAS DO PROGRAMA ' N1 ' E ' N2 
                                                                        
   CALL PROCURA_ORFA N1 N2                                              
                                                                        
   RETURN                                                               
                                                                        
/*--------------------------------------------------------------------*/
                                                                        
 PROCURA_ORFA:       /* logica principal para localizar as variaveis    
                        declaradas e nao utilizadas no programa */      
                                                                        
  ARG PRIMEIRA_LINHA ULTIMA_LINHA                                       
                                                                        
  ACHEI_ALGUMA = 'NAO'  /* indicador para verificar se achou sem uso */ 
  NUM. = 0                                                              
                                                                        
  J=1                                                                   
                                                                        
  SAY 'DETECTANDO AS VARIAVEIS DECLARADAS NO PROGRAMA...'               
                                                                        
  /* primeiro loop - varre as linhas da working ate a procedure */      
                                                                        
  DO I = PRIMEIRA_LINHA TO ULTIMA_LINHA                                 
                                                                        
    /* arquivo lindo de deus! */                                        
    PARSE VAR ENTRADA.I WITH 7 COL7 +1 STRING 73                        
    /* ignora comentarios, continuacao e quebra   */                    
    IF COL7 = '*' | COL7 = '-' | COL7 = '/' THEN                        
      NOP                                                               
    ELSE                                                                
    DO                                                                  
      /* procura se tem PIC na linha */                                 
      ACHOU = FIND(STRING,'PIC')                                        
      IF ACHOU > 1 THEN                                                 
        DO                                                              
     /* FILLER nao precisa sair na listagem */                          
        IF  WORD(STRING,ACHOU - 1) = 'FILLER' THEN                      
            NOP                                                         
        ELSE                                                            
            DO                                                          
     /* monta tabela com o nome das variaveis encontradas no programa */
               TAB_VAR.J = WORD(STRING,ACHOU - 1)                       
               SAY TAB_VAR.J   /* mostra qual variavel achamos */       
               IF  TAB_VAR.J <> " " THEN                                
                   J = J+1                                              
            END                                                         
        END                                                             
    END                                                                 
  END                                                                   
                                                                        
  /* JA ACHAMOS AS VARIAVEIS E CRIAMOS UMA TABELA */                    
  J = J-1                                                               
  DO I = ULTIMA_LINHA TO ENTRADA.0                                      
                                                                        
     DO K=1 TO J                                                        
       /* PEGA DA LINHA ATUAL DAS COLUNAS 7 A 73 E COLOCA EM CEBOLA */  
       PARSE VAR ENTRADA.I WITH 7 COL7 +1 CEBOLA 73                     
/*     VAR_K = FIND(TRANSLATE(CEBOLA,'','():'),TAB_VAR.K)  */           
       ROLA = TRANSLATE(CEBOLA,'','():.')                               
/*     SAY ROLA                                                         
          SAY 'VARIAVEL PESQUISADA -' TAB_VAR.K '-'  */                 
       VAR_K = FIND(TRANSLATE(CEBOLA,' ','.():'),TAB_VAR.K)             
       IF VAR_K <> 0 THEN                                               
          DO                                                            
    /*   SAY CEBOLA                                                     
         SAY VAR_K                                                      
         SAY 'ACHEI...' TAB_VAR.K  'EM ' CEBOLA     */                  
         NUM.TAB_VAR.K = 1                                              
          END                                                           
       ELSE                                                             
     /*    SAY TAB_VAR.K             */                                 
                        NOP                                             
                                                                        
     END                                                                
                                                                        
  END                                                                   
                                                                        
  /* RELATORIO DO PROCESSAMENTO */                                      
                                                                        
  SAY '------------------------'                                        
  SAY 'ENCONTRAMOS AS SEGUINTES'                                        
  SAY 'VARIAVEIS ORFAS'                                                 
  SAY '------------------------'                                        
  DO L = 1 TO J                                                         
    IF NUM.TAB_VAR.L <> 1 THEN DO                                       
      IF TAB_VAR.L = 'FILLER' THEN                                      
          NOP                                                           
       ELSE                                                             
          SAY TAB_VAR.L                                                 
          ACHEI_ALGUMA = 'SIM'                                          
       END                                                              
                                                                        
    ELSE                                                                
               NOP                                                      
                                                                        
  END                                                                   
                                                                        
  IF ACHEI_ALGUMA = 'NAO' THEN                                          
     SAY 'NAO DETECTADA NENHUMA VARIAVEL SEM REFERENCIA'                
  ELSE                                                                  
     SAY 'FIM DO PROCESSAMENTO, ENCERRA!'                               
                                                                        
  RETURN                                                                
                                                                        
/*--------------------------------------------------------------------*/
                                                                        
 ACHA_INI_FIM:     /* LOCALIZA LINHA CONTENDO UMA STRING RECEBIDA */    
                                                                        
  ARG PROCURAR     /* PROCURAR é O "PARAMETRO" A SER PESQUISADO */      
                                                                        
                                                                        
  DO QUAL_LINHA = 1 TO ENTRADA.0     /* ENTRADA.0 -> ULTIMA LINHA */    
/* DA COLUNA 7 ATEH A 73 */                                             
    PARSE VAR ENTRADA.QUAL_LINHA WITH 7 COL7 +1 STRING 73               
/* IGNORA COMENTARIOS, CONTINUACAO E QUEBRA   */                        
    IF COL7 = '/' | COL7 = '*' | COL7 = '-'  THEN                       
      NOP                                                               
    ELSE                                                                
    DO                                                                  
/* ACHOU A STRING QUE ESTAVAMOS PROCURANDO ? */                         
      ACHOU_1 = FIND(TRANSLATE(STRING,,'.'),PROCURAR)                   
      IF ACHOU_1 = 0 THEN                                               
        NOP                                                             
      ELSE                                                              
        LEAVE   /* SE O FIND RETORNOU <> 0 é PORQUE ACHOU, ENTAO VAZA */
    END                                                                 
  END                                                                   
                                                                        
  IF ACHOU_1 = 0 THEN QUAL_LINHA = 0                                    
                                                                        
 RETURN QUAL_LINHA   /* DEVOLVE QUAL A LINHA QUE FOI ENCONTRADA A       
                        STRING                                    */    
  BACKUP    CEBOLA
/* REXX */                                                              
PATH.1 = 'BUGAARQ.TEMP.DATA(BOLUDO)'   /* FONTE A SER ANALISADO */      
 "ALLOC DDN(INFILE) SHR REUSE DSN("PATH.1""                             
 "EXECIO * DISKR INFILE (STEM ENTRADA. FINIS"                           
   CALL ACHA_INI_FIM 'WORKING-STORAGE SECTION'                          
   N1 = RESULT                                                          
   CALL ACHA_INI_FIM 'PROCEDURE DIVISION'                               
   N2 = RESULT                                                          
   SAY 'VARIAVEIS PESQUISADAS ENTRE AS LINHAS ' N1 ' E ' N2 '.'         
                                                                        
   CALL PROCURA_ORFA N1 N2                                              
                                                                        
   RETURN                                                               
/*******************************************************************/   
 PROCURA_ORFA:                                                          
                                                                        
  ARG PRIMEIRA_LINHA ULTIMA_LINHA                                       
                                                                        
  FOUND = 0                                                             
  NUM. = 0                                                              
                                                                        
  J=1                                                                   
                                                                        
  DO I = PRIMEIRA_LINHA TO ULTIMA_LINHA                                 
                                                                        
    PARSE VAR ENTRADA.I WITH 7 COL7 +1 STRING 73                        
                                                                        
/* IGNORA COMENTARIOS, CONTINUACAO E QUEBRA   */                        
    IF COL7 = '*' | COL7 = '-' | COL7 = '/' THEN                        
                                                                        
      NOP                                                               
    ELSE                                                                
                                                                        
    DO                                                                  
/* VERIFICAR LOGICA PARA PIC EM OUTRA LINHA */                          
      NAO_ACHOU = FIND(STRING,'PIC')                                    
      IF NAO_ACHOU > 1 THEN                                             
        DO                                                              
          FSTRING.J = WORD(STRING,NAO_ACHOU - 1)                        
          IF  FSTRING.J <> " " THEN                                     
           J = J+1                                                      
          ELSE NOP                                                      
        END                                                             
      ELSE  NOP                                                         
    END                                                                 
  END                                                                   
  J = J-1                                                               
  DO I = ULTIMA_LINHA TO ENTRADA.0                                      
                                                                        
     DO K=1 TO J                                                        
       /* PEGA DA LINHA ATUAL DAS COLUNAS 7 A 73 E COLOCA EM CEBOLA */  
       PARSE VAR ENTRADA.I WITH 7 COL7 +1 CEBOLA 73                     
       VAR_K = FIND(TRANSLATE(CEBOLA,' ','():'),FSTRING.K)              
       IF VAR_K <> 0 THEN                                               
         NUM.FSTRING.K = 1                                              
                                                                        
       ELSE                                                             
     /*    SAY FSTRING.K             */                                 
                        NOP                                             
                                                                        
     END                                                                
                                                                        
  END                                                                   
                                                                        
  /* RELATORIO DO PROCESSAMENTO */                                      
                                                                        
  SAY '------------------------'                                        
  SAY 'ENCONTRAMOS AS SEGUINTES'                                        
  SAY 'VARIAVEIS ORFAS'                                                 
  SAY '------------------------'                                        
  DO L = 1 TO J                                                         
    IF NUM.FSTRING.L <1 THEN DO                                         
       IF FSTRING.L = 'FILLER' THEN                                     
          NOP                                                           
       ELSE                                                             
          SAY FSTRING.L                                                 
                                                                        
          FOUND = 1                                                     
                                                                        
       END                                                              
                                                                        
    ELSE                                                                
               NOP                                                      
                                                                        
  END                                                                   
                                                                        
  IF FOUND <> 1 THEN                                                    
     SAY 'NAO DETECTADA NENHUMA VARIAVEL SEM REFERENCIA'                
  ELSE                                                                  
     SAY 'FIM DO PROCESSAMENTO, ENCERRA!'                               
                                                                        
  RETURN                                                                
/*********************************************************************/ 
 ACHA_INI_FIM:                                                          
                                                                        
  ARG PHRASE                                                            
                                                                        
  DO QUAL_LINHA = 1 TO ENTRADA.0                                        
/* DA COLUNA 7 ATEH A 73 */                                             
    PARSE VAR ENTRADA.QUAL_LINHA WITH 7 COL7 +1 STRING 73               
/* IGNORA COMENTARIOS, CONTINUACAO E QUEBRA   */                        
    IF COL7 = '/' | COL7 = '*' | COL7 = '-'  THEN                       
                                                                        
      NOP                                                               
    ELSE                                                                
                                                                        
    DO                                                                  
                                                                        
      NAO_ACHOU = FIND(TRANSLATE(STRING,,'.'),PHRASE)                   
                                                                        
      IF NAO_ACHOU <> 0 THEN                                            
                                                                        
        LEAVE                                                           
      ELSE                                                              
        NOP                                                             
    END                                                                 
  END                                                                   