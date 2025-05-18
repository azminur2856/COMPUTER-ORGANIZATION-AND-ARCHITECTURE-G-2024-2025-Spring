.MODEL SMALL
.STACK 100H

.DATA
  MSG_INPUT  DB 'Input Hex Number (1 to 4 digits): $'
  MSG_OUTPUT DB 0DH, 0AH, 'Output: $'
  NEWLINE    DB 0DH, 0AH, '$'

.CODE
MAIN PROC
  MOV AX, @DATA
  MOV DS, AX

  XOR BX, BX         ; Clear BX to hold the result

  ; Display input prompt
  MOV AH, 9
  LEA DX, MSG_INPUT
  INT 21H

  ; First input
  MOV AH, 1
  INT 21H

WHILE_:
  CMP AL, 0DH        ; Check for Enter key
  JE END_WHILE

  ; Convert character to hex value
  CMP AL, '9'
  JG CHECK_LETTER    ; If > '9', check if it's a letter

  ; Digit 0–9
  AND AL, 0FH
  JMP SHIFT

CHECK_LETTER:
  CMP AL, 'f'
  JG READ_NEXT       ; Invalid, ignore
  CMP AL, 'a'
  JAE LOWERCASE

  ; It's uppercase A–F
  SUB AL, 'A'
  ADD AL, 10
  JMP SHIFT

LOWERCASE:
  SUB AL, 'a'
  ADD AL, 10
  JMP SHIFT

SHIFT:
  ; Left shift BX by 4 to make room
  MOV CL, 4
  SHL BX, CL

  ; Insert value into lower 4 bits
  OR BL, AL

  ; Read next character
READ_NEXT:
  MOV AH, 1
  INT 21H
  JMP WHILE_

END_WHILE:
  ; Display output label
  MOV AH, 9
  LEA DX, MSG_OUTPUT
  INT 21H

  ; Show BX as 4-digit hex
  MOV CX, 4          ; Loop 4 times
SHOW_LOOP:
  MOV DL, BH         ; Move high byte of BX to DL
  SHR DL, 4          ; Bring high nibble to lower bits

  CMP DL, 9
  JBE IS_NUM
  ADD DL, 7          ; Convert to A–F

IS_NUM:
  ADD DL, '0'
  MOV AH, 2
  INT 21H

  SHL BX, 4          ; Rotate BX left by 4 bits
  LOOP SHOW_LOOP

  ; Exit program
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN
