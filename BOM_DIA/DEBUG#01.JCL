//BUGA0002 JOB NG,BUGA,CLASS=K      RESTART=STEP#002                   
/*NOTIFY BUGAARQ                                                       
//*--------------------------------------------------------------------
//* Aloca arquivos utilizados pelo debug tool no z/OS                  
//*--------------------------------------------------------------------
//STEP#001  EXEC PGM=IEFBR14                                           
//SAVINGS      DD DSN=BUGAARQ.DEBUG.SAV.CONF,                        
//             DISP=(NEW,CATLG,DELETE),                                
//             UNIT=SYSDA,SPACE=(CYL,(20,10)),                         
//             DCB=(LRECL=3204,BLKSIZE=0,DSORG=PS,RECFM=VB)            
//SETTINGS      DD DSN=BUGAARQ.DEBUG.SAVE.SET,                        
//             DISP=(NEW,CATLG,DELETE),                                
//             UNIT=SYSDA,SPACE=(CYL,(20,10)),                         
//             DCB=(LRECL=3204,BLKSIZE=0,DSORG=PO,RECFM=VB),           
//             DSNTYPE=LIBRARY                                         
//*-------------------------------------------------------------------
//* Carrega configuracoes que o Buga gosta!                            
//*--------------------------------------------------------------------
//STEP#002  EXEC PGM=IEBGENER                                          
//SYSIN    DD DUMMY                                                    
//SYSPRINT DD SYSOUT=*                                                 
//SYSUT1   DD *                                                        
      COMMENT YES
      SET ASSEMBLER OFF;                                               
      SET ASSEMBLER STEPOVER EXTONLY;                                  
      SET AUTOMONITOR ON NOLOG CURRENT;                                
      SET CHANGE STATEMENT;                                            
      SET COLOR TURQUOISE NONE      HIGH TITLE HEADERS;                
      SET COLOR GREEN     NONE      LOW  TITLE FIELDS;                 
      SET COLOR TURQUOISE REVERSE   LOW  MONITOR AREA;                 
      SET COLOR TURQUOISE REVERSE   LOW  MONITOR LINES;                
      SET COLOR WHITE     REVERSE   LOW  SOURCE AREA;                  
      SET COLOR TURQUOISE REVERSE   LOW  SOURCE PREFIX;                
      SET COLOR YELLOW    REVERSE   LOW  SOURCE SUFFIX;                
      SET COLOR RED       REVERSE   HIGH SOURCE CURRENT;               
      SET COLOR GREEN     NONE      LOW  SOURCE BREAKPOINTS;           
      SET COLOR TURQUOISE NONE      HIGH PROGRAM OUTPUT;               
      SET COLOR YELLOW    NONE      LOW  TEST INPUT;                   
      SET COLOR GREEN     NONE      HIGH TEST OUTPUT;                  
      SET COLOR BLUE      REVERSE   HIGH LOG LINES;                    
      SET COLOR WHITE     NONE      HIGH COMMAND LINE;                 
      SET COLOR GREEN     REVERSE   HIGH WINDOW HEADERS;               
      SET COLOR BLUE      REVERSE   HIGH TOFEOF MARKER;                
      SET COLOR RED       NONE      HIGH TARGET FIELD;                 
      SET DEFAULT LISTINGS;                                            
      SET DEFAULT DBG;                                                 
      SET DEFAULT MDBG;                                                
      SET DEFAULT SCROLL PAGE;                                         
      SET DEFAULT VIEW STANDARD;                                       
      SET DEFAULT WINDOW SOURCE;                                       
      SET DISASSEMBLY OFF;                                             
      SET DYNDEBUG ON;                                                 
      SET ECHO ON;                                                     
      SET EXECUTE ON;                                                  
      SET EXPLICITDEBUG OFF;                                           
      SET FIND BOUNDS 1 *;                                             
      SET HISTORY ON 100;                                              
      SET IGNORELINK OFF;                                              
      SET LDD SINGLE;                                                  
      SET LIST TABULAR OFF;                                            
      SET LIST BY SUBSCRIPT OFF;                                       
      SET LOG OFF;                                                     
      SET LOG KEEP 1000;                                               
      SET LOG NUMBERS ON;                                              
      SET LONGCUNAME ON;                                               
      SET MONITOR DATATYPE OFF;                                        
      SET MONITOR LIMIT 1000;                                          
      SET MONITOR NUMBERS ON;                                          
      SET MONITOR WRAP ON;                                             
      SET MSGID OFF;                                                   
      SET PACE 2;                                                      
      SET PF1     "?" =    ?;                                          
      SET PF2     "STEP" = STEP;                                       
      SET PF3     "QUIT" = QUIT;                               
      SET PF4     "LIST" = LIST;                               
      SET PF5     "FIND" = IMMEDIATE FIND;                     
      SET PF6     "AT/CLEAR" =AT TOGGLE;                       
      SET PF7     "UP" =   IMMEDIATE UP;                       
      SET PF8     "DOWN" = IMMEDIATE DOWN;                     
      SET PF9     "GO" =   GO;                                 
      SET PF10    "ZOOM" = IMMEDIATE ZOOM;                     
      SET PF11    "ZOOM LOG" =IMMEDIATE ZOOM LOG;              
      SET PF12    "RETRIEVE" =IMMEDIATE RETRIEVE;              
      SET PF13    "?" =    ?;                                  
      SET PF14    "STEP" = STEP;                               
      SET PF15    "QUIT" = QUIT;                               
      SET PF16    "LIST" = LIST;                               
      SET PF17    "FIND" = IMMEDIATE FIND;                     
      SET PF18    "AT/CLEAR" =AT TOGGLE;                       
      SET PF19    "UP" =   IMMEDIATE UP;                       
      SET PF20    "DOWN" = IMMEDIATE DOWN;                     
      SET PF21    "GO" =   GO;                                 
      SET PF22    "ZOOM" = IMMEDIATE ZOOM;                     
      SET PF23    "ZOOM LOG" =IMMEDIATE ZOOM LOG;              
      SET PF24    "RETRIEVE" =IMMEDIATE RETRIEVE;              
      SET POPUP 15;                                            
      SET PROMPT LONG;                                         
      SET REFRESH OFF;                                         
      SET RESTORE SETTINGS AUTO;                               
      SET RESTORE BPS AUTO;                                    
      SET RESTORE MONITORS AUTO;                               
      SET REWRITE 50;                                          
      SET SAVE SETTINGS AUTO;                                  
      SET SAVE BPS AUTO FILE BUGAARQ.DEBUG.SAVE.SET;          
      SET SAVE MONITORS AUTO;                                  
      SET SCROLL DISPLAY ON;                                   
      SET SUFFIX ON;                                           
      SET WARNING ON;                                          
      WINDOW SIZE 3 LOG;                                   
      WINDOW SIZE 28 SOURCE;                               
      WINDOW SIZE 8 MONITOR;                               
      SET SCREEN ON;                                                   
      SET SCREEN 1 MONITOR SOURCE LOG;                                 
      SET KEYS ON 12;                                       
      SET MONITOR COLUMN ON;                                           
//SYSUT2   DD DSN=BUGAARQ.DEBUG.SAV.CONF,                            
//             DISP=(OLD,CATLG,DELETE),                                
//             UNIT=SYSDA,SPACE=(CYL,(20,10)),                         
//             DCB=(LRECL=3204,BLKSIZE=0,DSORG=PS,RECFM=VB)            
//                                                                     
//*                                                                    
                                                                       
SET SAVE SETTINGS AUTO ;                                               
SET SAVE BPS AUTO ;                                                    
SET SAVE MONITORS AUTO ;                                               
                                                                       
SET RESTORE SETTINGS AUTO ;                                            
SET RESTORE BPS AUTO ;                                                 
SET RESTORE MONITORS AUTO ;                                            
                                                                       
SET AUTO ON;                                                           
WINDOW SIZE 30 SOURCE; window size 3 log; 
