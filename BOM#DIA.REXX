/* REXX */                       
trace off;                       
CLEAR                            
SAY 'Ola Buga!'...               
SAY ' '                          
SAY 'Seja vem vindo...'         
SAY ' '                          
SAY ' '                          
parse PULL rola                  
/******************************/  
call verifica_primeira_vez_do_dia
say flag                         
if flag = 'S' then               
 do                              
   call grava_ja_rodamos;        
   call aloca_debug_tool_files;   
   call hrecall_de_tudo;          
 end;                            
ISPF                             
exit 0                           
/******************************/  
grava_ja_rodamos:                
/******************************/  
dsname = 'walbuga.apagador'      
"ALLOC FI(Pdsout) DA('"dsname"') new
  tracks space(10 10) dir(01)    
  Recfm(F B) LRECL(80)"          
"FREE  FI(Pdsout)"               
"allocate dataset('walbuga.apagador(#15)') fi(#15) shr reuse"
"execio 0 diskw #15 (stem o. open)"
o.1 = 'CEBOLA '                  
"execio * diskw #15 (stem o. finis)"
"free fi(#15)"                   
return                           
/******************************/  
verifica_primeira_vez_do_dia:    
/******************************/  
"allocate dataset('walbuga.apagador(#15)') fi(#15) shr reuse"
"execio * diskr #15 (stem oia. finis)"
  if pos('CEBOLA',oia.1) > '0' then
    do                            
      say 'TSO te derrubou, neh amigao ?'
      flag = 'N'                  
    end                           
  else                            
    do                            
      say 'Divirta-se Buga'        
      flag = 'S'                  
    end                           
return                           
/******************************/  
aloca_debug_tool_files:          
/******************************/  
debug_tool = "'WALBUGA.G#NG.SEMANA09(DEBUG#01)'"
SUBMIT debug_tool                
return                           
/******************************/  
hrecall_de_tudo:                 
recall = "'WALBUGA.G#R0.... DATA(JCL#0004)'"
SUBMIT recall                    
return
