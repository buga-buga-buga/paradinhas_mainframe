//BUGA0001 JOB SHOP,'BUGA',MSGLEVEL=(1,1),CLASS=K,MSGCLASS=1,RD=NC,       
//  NOTIFY=&SYSUID    ,RESTART=GO                                       
//*---------------------------------------------------------------------
//* Processo para compilar, likeditar e executar a ferramenta de testes 
//*                                                                     
//* AJEITA    - Gera arquivos de carga, temporarios e scratch saidas    
//*                                                                     
//* COMPILA   - Compilacao do programa ZUTZCPC vulgo ferramenta ou      
//*             pre-compilador                                          
//*                                                                     
//* LINKA     - Linkedita a crianca                                     
//*                                                                     
//* GO (COM DEBUG) - Executa a ferramenta no programa a ser testado,    
//*             para gerar o 'programa' que rodar  os testes            
//*                                                                     
//* GO2 (SEM DEBUG) - Executa a ferramenta no programa a ser testado    
//*             para gerar o 'programa' que rodar  os testes            
//*                                                                     
//* COMPILA2  - Compilacao do 'Pr0gRaMA' com os casos de teste, gerado  
//*             a partir do programa original COBOL e de outras inputs  
//*                                                                     
//* LINKA2    - Linkedita a crianca                                     
//*                                                                     
//* GO3       - Executa a ferramenta no programa a ser testado          
//*                                                                     
//*---------------------------------------------------------------------
/*NOTIFY BUGAARQ         ** ME NOTIFIQUE                                
/*XEQ UGA                ** RODAR EM BUGA                               
//*---------------------------------------------------------------------
//    EXPORT  SYMLIST=(USUARIO,TPEXEC,SMS2)                             
//    SET     USUARIO=&SYSUID,                                          
//            ZUTZCPC='ZUTZCPC',                nome do pre compilador  
//            TPEXEC='2',   ** Tipo de execucao                         
//*                            '1' com debug na execucao do teste       
//*                            '2' debug desligado                      
//*                            '3' compile e linkedite a ferramenta     
//*                       1 ou 2 bypass compilacao do pre-compilador    
//            SMS2='SIGLA',  ** segundo qualificados dos datasets        
//            DSNFONTE='BUGAARQ.SIGLA.CUT.COBOL', ** onde esta o fonte   
//*                                                   do pre-compilador 
//            DSNCARGA='BUGAARQ.SIGLA.LOADS'      ** onde esta o carga   
//*                                              dos testes unitarios ? 
//*---------------------------------------------------------------------
//*          SCRATCH TODOS OS ARQUIVOS DE SAIDA                         
//*  Ignore a execucao dos comandos, afinal estamos apenas ajeitando    
//* o ambiente, aproveira e sete se vamos usar ou nao o debug           
//*---------------------------------------------------------------------
//*                                                   do pre-compilador 
//AJEITA   EXEC PGM=IDCAMS                                              
//SYSPRINT DD SYSOUT=*                                                  
//SYSIN    DD *,DLM=FIM,SYMBOLS=JCLONLY                                 
    ALLOC DSNAME(&SMS2..LOADS) NEW DSORG(PO) DSNTYPE(LIBRARY)           
    ALLOC DSNAME(&SMS2..SYSDEBUG) NEW DSORG(PO) DSNTYPE(LIBRARY)        
    DELETE '&USUARIO..&SMS2..SYSMDECK'                                  
    SET MAXCC=&TPEXEC                                                   
FIM                                                                     
//*                                                   do pre-compilador 
//*---------------------------------------------------------------------
//*  Compila  o do "pr -compilador/ferramenta" de teste unitario        
//*---------------------------------------------------------------------
//*                                                   do pre-compilador 
//COMPILA  EXEC  PGM=IGYCRCTL,REGION=512M,COND=(3,LT,AJEITA),           
//       PARM=('OPTIMIZE(2),TEST')            ** COM DEBUG PRA ENTENDER 
//STEPLIB  DD  DISP=SHR,DSN=SYSP.COMPILA.V62.BIBS   ** COBOL 6.2   
//SYSMDECK DD  DSNAME=&USUARIO..&SMS2..SYSMDECK,         ** FONTE SAIDA 
//       UNIT=SYSDA,DISP=(NEW,CATLG),                                   
//       SPACE=(TRK,(3,3)),DCB=BLKSIZE=800                              
//SYSDEBUG DD  DISP=SHR,DSN=&USUARIO..&SMS2..SYSDEBUG(&ZUTZCPC)         
//*                                                      Debug File     
//SYSPRINT DD  SYSOUT=*                                                 
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT2   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT3   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT4   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT5   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT6   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT7   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT8   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT9   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT10  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))            * Necessarios na 
//SYSUT11  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))            * versao 6.2 do  
//SYSUT12  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))            * compilador do  
//SYSUT13  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))            * COBOL          
//SYSUT14  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))            *                
//SYSUT15  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))            *                
//SYSLIN   DD  DSN=&&LOADSET,DISP=(MOD,PASS),  ** load temporario       
//  SPACE=(TRK,(3,3)),DCB=BLKSIZE=800                                   
//SYSIN    DD  DISP=SHR,DSN=&DSNFONTE(&ZUTZCPC) ** Codigo fonte da      
//*                                                          Ferramenta 
//*---------------------------------------------------------------------
//*  Linkedita o "pr -compilador/ferramenta" de teste unitario          
//*---------------------------------------------------------------------
//*                                                                     
//LINKA    EXEC  PGM=IEWL,PARM='LIST,MAP',COND=(8,LT,COMPILA)           
//SYSLIN   DD  DSN=&&LOADSET,DISP=(OLD,DELETE)                          
//         DD  DDNAME=SYSIN                                             
//SYSLMOD  DD  DSN=&USUARIO..&SMS2..LOADS(&ZUTZCPC),DISP=SHR            
//* Abaixo sao as bibliotecas que vao nos ajudar nessa!         
//SYSLIB   DD  DISP=SHR,DSN=SYSP.LE.SCEELKED                            
//         DD  DISP=SHR,DSN=SYS2.LIBS.LOADS                            
//         DD  DISP=SHR,DSN=SYSP.COBOLRW.SCXRRUN                        
//         DD  DSNAME=BUGABIB.CHGMAN.SIGLA.PGMBAT01,DISP=SHR       
//         DD  DSN=BUGABIB.CHGMAN.SIGLA.PGMSUB01,DISP=SHR          
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSPRINT DD  SYSOUT=*                                                 
//*                                                          Ferramenta 
//*---------------------------------------------------------------------
//*  Execute a ferramenta !!!! Com o Debug ativado, esse passo gerar    
//* o programa que   o cenario do teste unitario para nosso programa    
//* COBOL a ser testado                                                 
//*---------------------------------------------------------------------
//*                                                                     
//  IF  AJEITA.RC = 1 THEN                                              
//GO       EXEC  PGM=&ZUTZCPC                                           
//*---------------------------------------------------------------------
//CEEOPTS   DD *,SYMBOLS=JCLONLY                                        
 TEST(ALL,*,PROMPT,VTAM%&USUARIO:*),                                    
//SYSDEBUG DD  DISP=SHR,DSN=&USUARIO..&SMS2..SYSDEBUG(&ZUTZCPC)         
//EQAOPTS  DD *    Maravilhas da retrocompatibilidade do mainframe!     
           EQAXOPT SVCSCREEN,ON,CONFLICT=OVERRIDE,NOMERGE               
           EQAXOPT  END                                                 
//*---------------------------------------------------------------------
//STEPLIB  DD  DSN=&DSNCARGA,DISP=SHR                                   
//SYSOUT   DD  SYSOUT=*                                                 
//*                                                                     
//* PROGRAMA FONTE ORIGINAL COMPLETO                                    
//*                                                                     
//SRCPRG   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(SAMPLE)              
//*                                                                     
//* CENARIO(S) DE TESTE                                                 
//*                                                                     
//*UTESTS   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.SAMPLET                       
//UTESTS   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(SAMPLET)             
//*                                                                     
//* NOME DOS BOOKS DE WORKING E DE PROCEDURE USADOS PELA FERRAMENTA     
//*                                                                     
//UTSTCFG  DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(UTSTCFG)             
//*                                                                     
//* CODIGO FONTE A SER COMPILADO E EXECUTADO COM OS CENARIOS A SEREM    
//* TESTADOS.                                                           
//*                                                                     
//TESTPRG  DD  DSN=&&PC,                                                
//         RECFM=FB,LRECL=00080,                                        
//         SPACE=(CYL,(10,10),RLSE),                                    
//         DISP=(MOD,PASS)                                              
//***** caso queira ver o fonte do caso de teste TESTPRG  DD  SYSOUT=*  
//  ENDIF                                                               
//*                                                          Ferramenta 
//*---------------------------------------------------------------------
//*  Execute a ferramenta !!!! Esse passo gerar  um programa que        
//* contempla os casos de teste que queremos testar                     
//*---------------------------------------------------------------------
//*                                                                     
//  IF (AJEITA.RC = 2)   THEN                                           
//*---------------------------------------------------------------------
//GO2      EXEC  PGM=ZUTZCPC         ** RODA A FERRAMENTA SEM DEBUG     
//*---------------------------------------------------------------------
//STEPLIB  DD  DSN=&DSNCARGA,DISP=SHR                                   
//*STEPLIB  DD  DSN=BUGAARQ.SIGLA.LOADS,DISP=SHR                         
//SYSOUT   DD  SYSOUT=*                                                 
//SRCPRG   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(SAMPLE)              
//** UTESTS   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.SAMPLET                     
//UTESTS   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(SAMPLET)             
//UTSTCFG  DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(UTSTCFG)             
//TESTPRG  DD  DSN=&&PC,                                                
//         RECFM=FB,LRECL=00080,                                        
//         SPACE=(CYL,(10,10),RLSE),                                    
//         DISP=(MOD,PASS)                                              
//  ENDIF                                                               
//*---------------------------------------------------------------------
//COMPILA2 EXEC  PGM=IGYCRCTL,COND=((8,LT,GO),(8,LT,GO2))               
//*                                  ** COMPILA PARA RODAR O TEST CASE  
//*---------------------------------------------------------------------
//STEPLIB  DD  DISP=SHR,DSN=SYSP.COMPILA.V42.BIBS                  
//SYSLIB   DD DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL                       
//SYSPRINT DD  SYSOUT=*                                                 
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT2   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT3   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT4   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSUT5   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT6   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT7   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT8   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT9   DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT10  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT11  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSLIN   DD  DSN=&&LOADSET,UNIT=SYSDA,DISP=(MOD,PASS),                
//         SPACE=(TRK,(3,3)),DCB=BLKSIZE=800                            
//SYSIN   DD  DSN=&&PC,DISP=(OLD,DELETE)                                
//*---------------------------------------------------------------------
//LINKA2   EXEC  PGM=IEWL,COND=(8,LT,COMPILA),                          
//        PARM='LIST,MAP'  ** EH UM COBOL, ENTAO LINKA                  
//*---------------------------------------------------------------------
//SYSLIN   DD  DSN=&&LOADSET,DISP=(OLD,DELETE)                          
//         DD  DDNAME=SYSIN                                             
//SYSLMOD  DD  DSN=BUGAARQ.SIGLA.LOADS(SAMPLE),DISP=SHR                  
//SYSLIB   DD DISP=SHR,DSN=SYSP.LE.SCEELKED                             
//         DD DISP=SHR,DSN=SYS2.LIBS.LOADS                             
//         DD DISP=SHR,DSN=SYSP.COBOLRW.SCXRRUN                         
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSPRINT DD  SYSOUT=*                                                 
//*---------------------------------------------------------------------
//GO3      EXEC  PGM=SAMPLE                ** EXECUTA O TESTE UNITARIO  
//*---------------------------------------------------------------------
//STEPLIB  DD  DSN=BUGAARQ.SIGLA.LOADS,DISP=SHR                          
//SYSOUT   DD  SYSOUT=*                                                 