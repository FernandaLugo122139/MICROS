#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program
i EQU 0x20
j EQU 0x21
k EQU 0x30
m EQU 0x31
a EQU 0x33
c EQU 0x34
aux EQU 0x35
aux2 EQU 0x36
pos EQU 0x37
n1 EQU 0x40
n2 EQU 0x41
n3 EQU 0x42
n4 EQU 0x43
n5 EQU 0x44
n6 EQU 0x45
n7 EQU 0x46
n8 EQU 0x47
x1 EQU 0x48
x2 EQU 0x49
x3 EQU 0x4a
x4 EQU 0x4b
x5 EQU 0x4c
x6 EQU 0x4d
x7 EQU 0x4e
x8 EQU 0x4f
 
START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    
    MOVLW b'00001111'
    MOVWF TRISD
    MOVLW b'00000000'
    MOVWF TRISA
    BCF STATUS,RP1
    BCF STATUS,RP0
  
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
  
EMPIEZO
    
    BTFSC PORTD,0
    goto $-1
    BCF PORTD,4
    call PANTALLA_INIT
    call tiempo1
    call tiempo1
    call tiempo1
    call INICIO
    
    MOVLW 0xC0
    MOVWF pos
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVFW pos	;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
 
 
    MOVLW d'9'
    MOVWF aux
    MOVLW 0x40
    MOVWF FSR
    goto cicloo
    regreso:
    call INICIO2
    
    MOVLW 0xD0
    MOVWF pos
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVFW pos	;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
 
   
    MOVLW d'9'
    MOVWF aux2
    MOVLW 0x48
    MOVWF FSR
    goto cicloo2
    regreso2:
    goto igual
    final:
    call tiempo1
    call tiempo1
    goto VAL
    goto $
    
    ;SKIP IF 0
cicloo:
    DECFSZ aux
    goto leer
    goto vali
    
cicloo2:
    DECFSZ aux2
    goto leer2
    goto vali2
       
igual:
    MOVFW n1
    XORWF x1
    BTFSS STATUS,Z
    call INCORRECTO
    MOVFW n2
    XORWF x2
    BTFSS STATUS,Z
    call INCORRECTO
    MOVFW n3
    XORWF x3
    BTFSS STATUS,Z
    call INCORRECTO 
    MOVFW n4
    XORWF x4
    BTFSS STATUS,Z
    call INCORRECTO 
    MOVFW n5
    XORWF x5
    BTFSS STATUS,Z
    call INCORRECTO
    MOVFW n6
    XORWF x6
    BTFSS STATUS,Z
    call INCORRECTO
    MOVFW n7
    XORWF x7
    BTFSS STATUS,Z
    call INCORRECTO
    MOVFW n8
    XORWF x8
    BTFSS STATUS,Z
    call INCORRECTO
    call CORRECTO
    
INICIO	  
   call INITLCD_1
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'P'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'S'
    MOVWF PORTB
    CALL exec

    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'W'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
     MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    return
    
    CORRECTO
call INITLCD_1
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'C'
    MOVWF PORTB
    CALL exec

    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
     MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'T'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x96	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
     MOVLW ':'
    MOVWF PORTB
    CALL exec
    
      MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    goto final
       
    
    INCORRECTO
call INITLCD_1
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'C'
    MOVWF PORTB
    CALL exec

    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
     MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x96	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
     MOVLW ':'
    MOVWF PORTB
    CALL exec
    
      MOVLW 'C'
    MOVWF PORTB
    CALL exec
    goto final
    
    INICIO2
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x90		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'N'
    MOVWF PORTB
    CALL exec

    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
   
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    return 
   
vali:
    
    BSF PORTD, 4
    BTFSC PORTD,0
    goto asterisco
    BCF PORTD,4
    BSF PORTD, 6
    BTFSC PORTD,0
    goto borrar
    BCF PORTD,6
    goto vali

    vali2:
    
     BSF PORTD, 4
    BTFSC PORTD,0
    goto asterisco2
    BCF PORTD,4
    BSF PORTD, 6
    BTFSC PORTD,0
    goto borrar_2
    BCF PORTD,6
    goto vali2
    
leer:
    
    BSF PORTD, 4
    BTFSC PORTD,1
    goto numero7
    BTFSC PORTD,2
    goto numero4
    BTFSC PORTD,3
    goto numero1
    BCF PORTD,4
    
    BSF PORTD, 5
    BTFSC PORTD,0
    goto numero0
    BTFSC PORTD,1
    goto numero8
    BTFSC PORTD,2
    goto numero5
    BTFSC PORTD,3
    goto numero2
    BCF PORTD,5
    
    BSF PORTD, 6
    BTFSC PORTD,0
    goto borrar
    BTFSC PORTD,1
    goto numero9
    BTFSC PORTD,2
    goto numero6
    BTFSC PORTD,3
    goto numero3
    BCF PORTD,6
    goto leer
    
    
    leer2:
    
    BSF PORTD, 4
    BTFSC PORTD,1
    goto numero7_2
    BTFSC PORTD,2
    goto numero4_2
    BTFSC PORTD,3
    goto numero1_2
    BCF PORTD,4
    
    BSF PORTD, 5
    BTFSC PORTD,0
    goto numero0_2
    BTFSC PORTD,1
    goto numero8_2
    BTFSC PORTD,2
    goto numero5_2
    BTFSC PORTD,3
    goto numero2_2
    BCF PORTD,5
    
    BSF PORTD, 6
    BTFSC PORTD,0
    goto borrar_2
    BTFSC PORTD,1
    goto numero9_2
    BTFSC PORTD,2
    goto numero6_2
    BTFSC PORTD,3
    goto numero3_2
    BCF PORTD,6
    goto leer2
    
    
   initpos:
   BCF PORTA,0		;command mode
   CALL time
    
    MOVFW pos		;LCD position
    MOVWF PORTB
    CALL exec
    
   BSF PORTA,0		;data mode
   CALL time
   goto leer
   
   
   initpos2:
   BCF PORTA,0		;command mode
   CALL time
    
    MOVFW pos		;LCD position
    MOVWF PORTB
    CALL exec
    
   BSF PORTA,0		;data mode
   CALL time
   goto leer2
  
    borrar:
   
    DECF pos
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVFW pos	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '_'
    MOVWF PORTB
    CALL exec
    
    INCF aux
    DECF FSR
      
    BTFSC PORTD,0
    goto $-1
    goto initpos
    
    
    borrar_2:
    
    DECF pos
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVFW pos	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '_'
    MOVWF PORTB
    CALL exec
    
    INCF aux2
    DECF FSR
    
    BTFSC PORTD,0
    goto $-1
    goto initpos2
    
    asterisco:
    BTFSC PORTD,0
    goto $-1
    goto regreso
   
    
    
     asterisco2:
    BTFSC PORTD,0
    goto $-1
    goto regreso2
  
    
    numero0:
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    MOVLW d'0'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,0
    goto $-1
    goto cicloo
    
    numero0_2:
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    MOVLW d'0'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,0
    goto $-1
    goto cicloo2
   
    
    numero1:
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    MOVLW d'1'
    MOVWF INDF
    INCF FSR
     INCF pos
    BTFSC PORTD,3
    goto $-1
    goto cicloo
    
    
    numero1_2:
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    MOVLW d'1'
    MOVWF INDF
    INCF FSR
     INCF pos
    BTFSC PORTD,3
    goto $-1
    goto cicloo2
   
    
    numero2:
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    MOVLW d'2'
    MOVWF INDF
    INCF pos
    INCF FSR
    BTFSC PORTD,3
    goto $-1
    goto cicloo
    
    numero2_2:
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    MOVLW d'2'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,3
    goto $-1
    goto cicloo2
    
 
    numero3:
     
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    MOVLW d'3'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,3
    goto $-1
    goto cicloo
    
    
    numero3_2:
   
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    MOVLW d'3'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,3
    goto $-1
    goto cicloo2
    
   
    numero4:

    MOVLW '4'
    MOVWF PORTB
    CALL exec
    MOVLW d'4'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,2
    goto $-1
    goto cicloo
    
     numero4_2:
   
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    MOVLW d'4'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,2
    goto $-1
    goto cicloo2
    
   
    numero5:

    MOVLW '5'
    MOVWF PORTB
    CALL exec
    MOVLW d'5'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,2
    goto $-1
    goto cicloo
    
     numero5_2:
   
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    MOVLW d'5'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,2
    goto $-1
    goto cicloo2

    
    numero6:

    MOVLW '6'
    MOVWF PORTB
    CALL exec
    MOVLW d'6'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,2
    goto $-1
    goto cicloo
    
     numero6_2:

    MOVLW '6'
    MOVWF PORTB
    CALL exec
    MOVLW d'6'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,2
    goto $-1
    goto cicloo2
    

    numero7:

    MOVLW '7'
    MOVWF PORTB
    CALL exec
    MOVLW d'7'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,1
    goto $-1
    goto cicloo
    
     numero7_2:
 
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    MOVLW d'7'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,1
    goto $-1
    goto cicloo2

    
    numero8:
   
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    MOVLW d'8'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,1
    goto $-1
    goto cicloo
    
    numero8_2:
  
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    MOVLW d'8'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,1
    goto $-1
    goto cicloo2
    
    numero9:

    MOVLW '9'
    MOVWF PORTB
    CALL exec
    MOVLW d'9'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,1
    goto $-1
    goto cicloo
    
    
    numero9_2:

    MOVLW '9'
    MOVWF PORTB
    CALL exec
    MOVLW d'9'
    MOVWF INDF
    INCF FSR
    INCF pos
    BTFSC PORTD,1
    goto $-1
    goto cicloo2
    
exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN

    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN

    INITLCD_1:
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    return
    
tiempo1:
movlw d'180' ;establecer valor de la variable m
movwf m
mloop:
decfsz m,f
goto mloop

movlw d'75' ;establecer valor de la variable i
movwf a
aloop:
nop;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable j
movwf c
cloop:
nop
;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable k
movwf k
kloop:
decfsz k,f
goto kloop
decfsz c,f
goto cloop
decfsz a,f
goto aloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa


tiempo3
    MOVLW d'10'
    MOVWF i
cicloj:
    MOVLW d'20'
    MOVWF j
ciclok:
    MOVLW d'200'
    MOVWF k
cicloi:
    NOP
    NOP
    DECFSZ k, 1
    GOTO cicloi
    DECFSZ j, 1
    GOTO ciclok
    DECFSZ i, 1
    GOTO cicloj
    RETURN
    
    
    VAL2: 
    BSF PORTD, 4
    BTFSC PORTD,0
    goto regreso2
    goto VAL2
    
    
    VAL: 
    BSF PORTD, 4
    BTFSC PORTD,0
    goto EMPIEZO
    goto VAL
    
    
    
    PANTALLA_INIT
call INITLCD_1
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x84		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'C'
    MOVWF PORTB
    CALL exec

    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x8A	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC3	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'P'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'R'
    MOVWF PORTB
    CALL exec

    MOVLW 'C'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'L'
    MOVWF PORTB
    CALL exec

    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xCB	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW '#'
    MOVWF PORTB
    CALL exec
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x94	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    CALL exec
   
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    
    MOVLW '-'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    
     
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD6	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'G'
    MOVWF PORTB
    CALL exec
    
     MOVLW 'L'
    MOVWF PORTB
    CALL exec
   
    return
    
    
   
    END