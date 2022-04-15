#include "p10f200.inc"
	__CONFIG _WDT_OFF & _CP_OFF & _MCLRE_ON
	ORG 0x0000
 
d1   	    EQU   	 10   	 ;define 0x10 register as lower delay byte
d2   	    EQU   	 11   	 ;define 0x11 register as upper delay byte
periods    EQU   	 12   	 ;define 0x12 register as number of periods to play
 
INIT
    MOVLW  ~(1<<T0CS)         ;enable GPIO2
    OPTION   			 
    MOVLW ~(1 << GP2)          ;set GP2 as an output
    TRIS GPIO
LOOP; PLAY BEGINNING OF 'RIDE OF THE VALKYRIES'
    CALL H1
    CALL E2
    CALL H1
    CALL E2
    CALL G#1
    CALL E2
    CALL G#1
    CALL E2
    CALL G#1
    CALL H1
    CALL G#1
    CALL H1
    CALL G#1
    CALL H1
    CALL D2
    CALL D2
    CALL G#1
    CALL D2
    CALL G#1
    CALL H1
    CALL G#1
    CALL D2
    CALL G#1
    CALL H1
    BCF  GPIO, GP2; SET GP2 LOW,TO KEEP BUZZER FROM BUZZING INDEFINITELY
    SLEEP;ENABLE SLEEP, CONSERVE POWER
    GOTO LOOP;LOOP FOREVER
    
E2  				 ;Note E of the 2nd octave
    MOVLW D'255'   	             ;Load the number of periods to play
    MOVWF periods
LOOP_E2   			 ;Toggle pin GP2 with the specified frequency
    MOVLW (1<<GP2)   	 
    XORWF GPIO, F      	 ;Toggle GP2
    MOVLW D'251'   	 
    MOVWF d1   		 ;Load lower delay byte
    MOVLW 1   		 
    MOVWF d2   		 ;Load upper delay byte
    CALL DELAY   		 ;Perform delay
    DECFSZ periods, F             ;Decrease the number of periods and check if it is 0
    GOTO LOOP_E2   	 ;If no then keep toggling GP2
    RETLW 0  
    
D#2
    MOVLW D'240'
    MOVWF periods
LOOP_D#2
    MOVLW (1<<GP2)
    XORWF GPIO, F      	
    MOVLW D'10'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_D#2
    RETLW 0

H1
    MOVLW D'191'
    MOVWF periods
LOOP_H1
    MOVLW (1<<GP2)
    XORWF GPIO, F      	
    MOVLW D'80'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_H1
    RETLW 0
 
D2
    MOVLW D'227'
    MOVWF periods
LOOP_D2
    MOVLW (1<<GP2)
    XORWF GPIO, F      	
    MOVLW D'26'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_D2
    RETLW 0
 
C2
    MOVLW D'202'
    MOVWF periods
LOOP_C2
    MOVLW (1<<GP2)
    XORWF GPIO, F      	
    MOVLW D'61'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_C2
    RETLW 0
 
A1
    MOVLW D'170'
    MOVWF periods
LOOP_A1
    MOVLW (1<<GP2)
    XORWF GPIO, F      	 
    MOVLW D'121'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_A1
    RETLW 0
 
C1
    MOVLW D'101'
    MOVWF periods
LOOP_C1
    MOVLW (1<<GP2)
    XORWF GPIO, F      	 
    MOVLW D'123'
    MOVWF d1
    MOVLW 3
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_C1
    RETLW 0
 
E1
    MOVLW D'127'
    MOVWF periods
LOOP_E1
    MOVLW (1<<GP2)
    XORWF GPIO, F      	 
    MOVLW D'248'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_E1
    RETLW 0
 
G#1
    MOVLW D'160'
    MOVWF periods
LOOP_G#1
    MOVLW (1<<GP2)
    XORWF GPIO, F      	 
    MOVLW D'144'
    MOVWF d1
    MOVLW 2
    MOVWF d2
    CALL DELAY
    DECFSZ periods, F
    GOTO LOOP_G#1
    RETLW 0

DELAY; DELAY SUBROUTINE
    DECFSZ d1, F; DECREMENT REGISTER 0x10, CHECK IF ZERO
    GOTO DELAY; IF NOT ZERO, GO TO START OF DELAY SUBROUTINE
    DECFSZ d2, F; ELSE DECREMENT REGISTER 0x11, CHECK IF ZERO
    GOTO DELAY; IF NOT ZERO, GO TO START OF DELAY SUBROUTINE
    RETLW 0; ELSE RETURN FROM THE SUBROUTINE
    
    END


