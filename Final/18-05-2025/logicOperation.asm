.MODEL SMALL

.STACK 100H

.DATA
 
.CODE

MAIN PROC

INPUT:
 
   MOV AH,1

   INT 21H      

   AND AL,0DFH

OUTPUT:     

   MOV AH,2

   MOV DL,AL

   INT 21H   

 
 
EXIT:

    MOV AH,4CH

    INT 21H 

MAIN ENDP

END MAIN                            
 