/**  REXX  **/                                                         
arg sigla pacote texto                                                 
call valida_parametros;                                                
call verifica_se_pacote_existe;                                        
/* aqui a magica acontece! */                                          
call outtrap "mbrs."                                                   
"LISTD" "'"pdsname"'" "MEMBERS"                                        
call outtrap "off"                                                     
                                                                       
do ndx=1 to mbrs.0                                                     
   if mbrs.ndx = "--MEMBERS--" then leave                              
end                                                                    
ndx=ndx+1                                                              
qtd_membros = mbrs.0 - ndx + 1                                         
say 'Procuraremos a string em ' qtd_membros ' membros.'                
/* "ALLOC FI(RELAT) DA('WALBUGA.OUTDD.SAIDA') MOD REUSE" */            
log = USERID()'.OUTDD.SAIDA'                                           
say log                                                                
/* "ALLOC FI(RELAT) DA(log) MOD REUSE"                                 
   "ALLOC F(SYS010) DS('"particionado"("membro")') SHR REUSE"          
   "ALLOC FI(RELAT) DA('WALBUGA.OUTDD.SAIDA') MOD REUSE"  */           
 "ALLOC FI(RELAT) DA('"log"') MOD REUSE"                               
IF RC \= 0 THEN                                                        
   DO                                                                  
      say "----------------------------------------"                   
      say "Erro na alocacao do arquivo de relatorio"                   
      say "----------------------------------------"                   
     EXIT 0                                                            
   END                                                                 
/* aqui a magica acontece 2! */                                        
call listdsi "'"pdsname"'"                                             
particionado=sysdsname                                                 
/**-----------------------------------------------------------------**/
linha.1="------------------------------------------------"             
linha.2="Inicio do processamento ------------------------"             
linha.3="------------------------------------------------"              
linha.4="Procurando " pdsname " por <" texto ">"                        
linha.5="------------------------------------------------"              
linha.0=5                                                               
"EXECIO" linha.0 "DISKW RELAT (STEM linha."                             
do curmbr = ndx to mbrs.0                                               
   parse value mbrs.curmbr with membro                                  
   membro=strip(membro)                                                 
   flag=1                                                               
/* say "member="particionado"("membro")" */                             
/* assim sai o membro */                                                
/* aqui =  'particionadome' ||(membro) */                               
/* aqui = "'"(membro)"'" */                                             
/* say aqui */                                                          
/* "ALLOC F(SYS010) DS('"particionado"("membro")') SHR REUSE" */        
   "ALLOC F(SYS010) DS('"particionado"("membro")') SHR REUSE"           
/* "ALLOC F(SYS010) DS("'"aqui"'") SHR REUSE" */                        
   "EXECIO * DISKR SYS010 (FINIS STEM in."                              
   "FREE F(SYS010)"                                                     
   fnd=0                                                                
   do recid=1 to in.0                                                   
      if pos(texto,in.recid) > 0 then                                   
        do                                                              
           if flag = 1 then                                             
             do                                                         
              linha.1="------------------------------------------------"
              linha.2="----> " membro " contem <" texto ">"             
              say linha.2                                               
              linha.3 = in.recid                                        
              linha.0=3                                                 
              "EXECIO" linha.0 "DISKW RELAT (STEM linha."               
              flag=0                                                    
             end                                                        
           linha.1 = in.recid                                           
           linha.0=1                                                    
           "EXECIO" linha.0 "DISKW RELAT (STEM linha."                  
        end                                                             
   end                                                                  
end                                                                    
say '*** Pesquisa finalizada com sucesso ***'                          
linha.1="////////////////////////////////////////////////"             
linha.2="////////////////////////////////////////////////"             
linha.3="////////////////////////////////////////////    "             
linha.4="//////////////////////////////////////////// FIM"             
linha.5="////////////////////////////////////////////////"             
linha.0=5                                                              
"EXECIO" linha.0 "DISKW RELAT (STEM linha."                            
"EXECIO 0 DISKW RELAT (FINIS"                                          
"FREE F(RELAT)"                                                        
exit 0                                                                 
                                                                       
/*----------------------- */                                           
valida_parametros:                                                     
/*----------------------- */                                           
if sigla = "" | pacote = "" | texto = "" then                          
 do                                                                    
   clear                                                               
   say ""                                                              
   say "Bem vindo "  USERID()                                          
   say ""                                                              
   say  "Informe: "                                                    
   say  " - sigla do sistema"                                          
   say  " - numero do pacote "                                         
   say  " - string a ser pesquisada"                                   
   say ""                                                              
   say  "Como não foi informado abrirei a opcao de informar abaixo."   
   say ""                                                              
   say  "Digite SAI para sair, tecle ENTER para continuar..."          
   pull ok                                                             
   say ""                                                              
   /* if parse upper (ok) = 'SAI' then         -- VER USO DO UPPER */  
   if ok = 'SAI' then                                                  
    do                                                                 
      exit 0                                                           
    end                                                                
 end                                                                   
if sigla = "" then                                                     
   do                                                                  
      say "----------------------------------------------------"       
      say "Erro: Informe a sigla do sistema com duas posicoes"         
      say "----------------------------------------------------"       
      say ""                                                           
      say 'Digite a sigla:'                                            
      pull sigla                                                       
   end                                                                 
if pacote = "" then                                                    
   do                                                                  
      say "--------------------------------"                           
      say "Erro: Não foi informado o pacote"                           
      say "--------------------------------"                           
      say ""                                                           
      say "Procuraremos em DESICBIB.CHGMAN.STG.NG0I.#pacote.SRC"       
      say ""                                                           
      say 'Digite o numero do pacote com 6 numeros :'                  
      pull pacote                                                      
   end                                                                 
if texto = "" then                                                     
   do                                                                  
      say "-----------------------------------------------------------"
      say "Erro: Não foi informada a string a ser pesquisada no pacote"
      say "-----------------------------------------------------------"
      say ""                                                           
      say 'Digite a string:'                                           
      pull texto                                                       
   end                                                                 
return                                                                 
                                                                       
                                                                       
/*------------------------------------- */                             
verifica_se_pacote_existe:                                             
/*------------------------------------- */                             
                                                                       
/*         DESICBIB.CHGMAN.STG.NG0I.#000651.SRC */                     
pdsname = 'DESICBIB.CHGMAN.STG.'sigla'0I.#'pacote'.SRC'                
 	say '---------------------------------------------------------------' 
 	say 'Procurando' texto ' em 'pdsname''                                
 	say '---------------------------------------------------------------' 
 	x = SYSDSN("'"pdsname"'")      /* só pros feras!!! ODEIO ISSO */      
 	say x ', vamos em frente que o pacote ta lá!'                         
 	say '---------------------------------------------------------------' 
 	if x <> "OK" then                                                     
 	   do                                                                 
 	      say "Erro: Não conseguimos localizar o pacote #" pacote         
 	      say "Erro: Não conseguimos localizar o pacote:" pdsname         
 	      say "Error: " pdsname " > " sysdsn(pdsname)                     
 	      say "Press Enter to continue"                                   
 	      pull uresp                                                      
 	      exit 8                                                          
 	   end                                                                
 	return                                             