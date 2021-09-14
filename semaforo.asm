#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33
a equ 0x34
c equ 0x35
r equ 0x36
e equ 0x37
;inicio del programa:
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0
NOP
 
semaforo:
MOVLW b'00100001' 
MOVWF PORTB  
call tiempo5
MOVLW b'00100010'
MOVWF PORTB
call tiempo1
MOVLW b'00001100'
MOVWF PORTB
nop
nop
call tiempo5
MOVLW b'00010100'
MOVWF PORTB
call tiempo1
GOTO semaforo

tiempo1:
movlw d'180' ;establecer valor de la variable m
movwf m
mloop:
decfsz m,f
goto mloop

movlw d'90' ;establecer valor de la variable i
movwf i
iloop:
nop;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable j
movwf j
jloop:
nop
;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable k
movwf k
kloop:
decfsz k,f
goto kloop
decfsz j,f
goto jloop
decfsz i,f
goto iloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
    
tiempo5:
 nop
 nop
 nop
 nop
 nop
 nop
movlw d'156' ;establecer valor de la variable m
movwf a
aloop:
 nop
 nop
 nop
 nop
 nop
 nop
 nop
decfsz a,f
goto aloop
    
movlw d'166' ;establecer valor de la variable i
movwf c
cloop:
  nop
 nop
 nop
 nop
 nop
 nop
 nop
;NOPs de relleno (ajuste de tiempo)
movlw d'100' ;establecer valor de la variable j
movwf r
rloop:
nop
nop
nop
;NOPs de relleno (ajuste de tiempo)
movlw d'98' ;establecer valor de la variable k
movwf e
eloop:
decfsz e,f
goto eloop
decfsz r,f
goto rloop
decfsz c,f
goto cloop
    
    return
END