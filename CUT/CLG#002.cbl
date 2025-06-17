//BUGAARQ1 JOB SHOP,'BUGA',MSGLEVEL=(1,1),CLASS=K,MSGCLASS=1,RD=NC,       
//  NOTIFY=&SYSUID    ,RESTART=GO                                       
//*---------------------------------------------------------------------
//* Processo para compilar, likeditar e executar a ferramenta de testes 
//*                                                                     
//* COMPILA   - Compilacao do programa ZUTZCPC                          
//* LINKA     - Linkedita a crianca                                     
//* GO (COM DEBUG) - Executa a ferramenta no programa a ser testado,    
//*             para gerar o 'programa' que rodar  os testes            
//* GO2 (SEM DEBUG) - Executa a ferramenta no programa a ser testado    
//*             para gerar o 'programa' que rodar  os testes            
//*                                                                     
//* COMPILA2  - Compilacao o 'programa' que sera testado                
//* LINKA2    - Linkedita a crianca                                     
//*                                                                     
//* GO3       - Executa a ferramenta no programa a ser testado          
//*                                                                     
//*---------------------------------------------------------------------
/*NOTIFY BUGAARQ         ** ME NOTIFIQUE                                
/*XEQ UGA                ** RODAR EM BUGA                               
//*---------------------------------------------------------------------
//    EXPORT  SYMLIST=(USUARIO,DEBUG)                                   
//    SET     USUARIO=&SYSUID,                                          
//            DEBUG='2'   ** 1 - Ligado  / 2 - Desligado                
//*---------------------------------------------------------------------
//*          SCRATCH TODOS OS ARQUIVOS DE SAIDA                         
//*---------------------------------------------------------------------
//ALOCA    EXEC PGM=IDCAMS                                              
//SYSPRINT DD SYSOUT=*                                                  
//SYSIN    DD *,DLM=FIM,SYMBOLS=JCLONLY                                 
    ALLOC DSNAME(LOADS) NEW DSORG(PO) DSNTYPE(LIBRARY)                  
    ALLOC DSNAME(SYSDEBUG) NEW DSORG(PO) DSNTYPE(LIBRARY)               
    DELETE 'BUGAARQ.DOIS'                                               
    DELETE 'BUGAARQ.TRES'                                               
    SET MAXCC=&DEBUG                                                    
FIM                                                                     
//*---------------------------------------------------------------------
//*          SCRATCH TODOS OS ARQUIVOS DE SAIDA                         
//*---------------------------------------------------------------------
//SCRATCH  EXEC  PGM=IEFBR14                                            
//*---------------------------------------------------------------------
//SYSPRINT DD  SYSOUT=*                                                 
//SYSOUT   DD  SYSOUT=*                                                 
//DD1      DD  DISP=(MOD,DELETE,DELETE),                                
//             DSN=BUGAARQ.TRES,SPACE=(TRK,(1,1),RLSE)                  
//DD1      DD  UNIT=DASD,DISP=(MOD,DELETE,DELETE),                      
//             DSN=BUGAARQ.DOIS,SPACE=(TRK,0)                           
//*---------------------------------------------------------------------
//COMPILA  EXEC  PGM=IGYCRCTL,REGION=512M,                              
//       PARM=('OPTIMIZE(2),TEST')      ** COM DEBUG PRA ENTENDER       
//STEPLIB  DD  DISP=SHR,DSN=SYSP.COMPILA.V62.BIBS      ** COBOL    
//SYSMDECK DD  DSNAME=BUGAARQ.TRES,UNIT=SYSDA,DISP=(NEW,CATLG),         
//       SPACE=(TRK,(3,3)),DCB=BLKSIZE=800                  ** NEW      
//SYSDEBUG DD  DISP=SHR,DSN=BUGAARQ.SIGLA.SYSDEBUG(ZUTZCPC)  ** DEBUG    
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
//SYSUT12  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT13  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT14  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSUT15  DD  UNIT=SYSDA,SPACE=(CYL,(5,5))                             
//SYSLIN   DD  DSN=&&LOADSET,DISP=(MOD,PASS),                           
//  SPACE=(TRK,(3,3)),DCB=BLKSIZE=800                                   
//*SYSLIN   DD  DSN=BUGAARQ.DOIS,UNIT=SYSDA,DISP=(NEW,CATLG),           
//*       SPACE=(TRK,(3,3)),DCB=BLKSIZE=800                             
//SYSIN    DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(ZUTZCPC) ** CODIGO   
//*                                            ** FONTE DA FERRAMENTA   
//*---------------------------------------------------------------------
//LINKA    EXEC  PGM=IEWL,PARM='LIST,MAP'                               
//*---------------------------------------------------------------------
//*SYSLIN   DD  DSN=BUGAARQ.DOIS,DISP=SHR                               
//SYSLIN   DD  DSN=&&LOADSET,DISP=(OLD,DELETE)                          
//         DD  DDNAME=SYSIN                                             
//SYSLMOD  DD  DSN=BUGAARQ.SIGLA.LOADS(ZUTZCPC),DISP=SHR                 
//SYSLIB   DD  DISP=SHR,DSN=SYSP.LE.SCEELKED                            
//         DD  DISP=SHR,DSN=SYS2.LIBS.LOADS                            
//         DD  DISP=SHR,DSN=SYSP.COBOLRW.SCXRRUN                        
//         DD  DSN=BUGABIB.CHGMAN.SIGLA.PGMBAT01,DISP=SHR         
//         DD  DSN=BUGABIB.CHGMAN.SIGLA.PGMSUB01,DISP=SHR         
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(1,1))                             
//SYSPRINT DD  SYSOUT=*                                                 
//         IF  ALOCA.RC = 1 THEN                                        
//GO       EXEC  PGM=ZUTZCPC         ** RODA A FERRAMENTA COM DEBUG     
//*---------------------------------------------------------------------
//CEEOPTS   DD *                                                        
 TEST(ALL,*,PROMPT,VTAM%BUGAARQ:*),                                     
//SYSDEBUG DD DISP=SHR,DSN=BUGAARQ.SIGLA.SYSDEBUG                        
//**EQADEBUG DD DISP=SHR,DSN=BUGAARQ.SIGLA.SYSDEBUG                      
//EQAOPTS  DD *                                                         
           EQAXOPT SVCSCREEN,ON,CONFLICT=OVERRIDE,NOMERGE               
           EQAXOPT  END                                                 
//*---------------------------------------------------------------------
//STEPLIB  DD  DSN=BUGAARQ.SIGLA.LOADS,DISP=SHR                          
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
//TESTPRG  DD  SYSOUT=*                                                 
//         ELSE                                                         
//*---------------------------------------------------------------------
//GO2      EXEC  PGM=ZUTZCPC         ** RODA A FERRAMENTA SEM DEBUG     
//*---------------------------------------------------------------------
//STEPLIB  DD  DSN=BUGAARQ.SIGLA.LOADS,DISP=SHR                          
//SYSOUT   DD  SYSOUT=*                                                 
//SRCPRG   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(SAMPLE)              
//UTESTS   DD  DISP=SHR,DSN=BUGAARQ.SIGLA.SAMPLET                        
//UTSTCFG  DD  DISP=SHR,DSN=BUGAARQ.SIGLA.CUT.COBOL(UTSTCFG)             
//TESTPRG  DD  DSN=&&PC,                                                
//         RECFM=FB,LRECL=00080,                                        
//         SPACE=(CYL,(10,10),RLSE),                                    
//         DISP=(MOD,PASS)                                              
//     ENDIF                                                            
//*---------------------------------------------------------------------
//COMPILA2 EXEC  PGM=IGYCRCTL        ** COMPILA PARA RODAR O TEST CASE  
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
//LINKA2   EXEC  PGM=IEWL,PARM='LIST,MAP'  ** EH UM COBOL, ENTAO LINKA  
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