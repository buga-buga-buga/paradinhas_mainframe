       IDENTIFICATION DIVISION.                                        
       PROGRAM-ID. HELLO.                                              
       ENVIRONMENT DIVISION.                                           
       CONFIGURATION SECTION.                                          
       SPECIAL-NAMES.                                                  
       DATA DIVISION.                                                  
       WORKING-STORAGE SECTION.                                        
       01 1A.                                                          
          03 1D VALUE X'C885939396' PICTURE XXXXXXXXXXXX.              
          03 1C PIC X(7) VALUE X'40E6969993845A'.                     
       PROCEDURE DIVISION.                                             
           MOVE 1C TO 1D(6:7)                                          
           DISPLAY 1A                                                  
           STOP RUN                                                    
           .                                                        
