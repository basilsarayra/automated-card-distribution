
_main:

;MyProject_basil.c,15 :: 		void main() {
;MyProject_basil.c,16 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;MyProject_basil.c,17 :: 		TRISD = 0b00000000;
	CLRF       TRISD+0
;MyProject_basil.c,18 :: 		ATD_init();
	CALL       _ATD_init+0
;MyProject_basil.c,20 :: 		msDelay(50);
	MOVLW      50
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,25 :: 		portb.f2 =1;  ////////////////////////// direction
	BSF        PORTB+0, 2
;MyProject_basil.c,26 :: 		portb.f5 =1;/////////////////////// enable
	BSF        PORTB+0, 5
;MyProject_basil.c,27 :: 		portb.f1 =0;  //////////////////////////// led
	BCF        PORTB+0, 1
;MyProject_basil.c,28 :: 		portd.f1 =0;//////////////////////dc driver
	BCF        PORTD+0, 1
;MyProject_basil.c,31 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,32 :: 		for (x = 0; x < 1600; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main0:
	MOVLW      128
	XORWF      _x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      6
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      64
	SUBWF      _x+0, 0
L__main55:
	BTFSC      STATUS+0, 0
	GOTO       L_main1
;MyProject_basil.c,33 :: 		portb.f2 =1;
	BSF        PORTB+0, 2
;MyProject_basil.c,34 :: 		portb.f5 =0;
	BCF        PORTB+0, 5
;MyProject_basil.c,36 :: 		k = ATD_read();  // 0-1023
	CALL       _ATD_read+0
	MOVF       R0+0, 0
	MOVWF      _k+0
	MOVF       R0+1, 0
	MOVWF      _k+1
;MyProject_basil.c,37 :: 		v = ((k*4.8)/1023);
	CALL       _int2double+0
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      25
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
	MOVF       R0+2, 0
	MOVWF      _v+2
	MOVF       R0+3, 0
	MOVWF      _v+3
;MyProject_basil.c,38 :: 		if(v>=1.5 && counter2==0){ counter2++;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      64
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
	MOVLW      0
	XORWF      _counter2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      0
	XORWF      _counter2+0, 0
L__main56:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
L__main53:
	INCF       _counter2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter2+1, 1
;MyProject_basil.c,39 :: 		counter = counter+1;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;MyProject_basil.c,40 :: 		players[counter] = x;
	MOVF       _counter+0, 0
	MOVWF      R0+0
	MOVF       _counter+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _players+0
	MOVWF      FSR
	MOVF       _x+0, 0
	MOVWF      INDF+0
	MOVF       _x+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;MyProject_basil.c,41 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,42 :: 		portb.f1 =1;
	BSF        PORTB+0, 1
;MyProject_basil.c,43 :: 		msDelay(1000);
	MOVLW      232
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      3
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,44 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,45 :: 		portb.f1 =0;}
	BCF        PORTB+0, 1
L_main5:
;MyProject_basil.c,47 :: 		if(v<1.2){counter2=0;}
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      25
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	MOVF       _v+0, 0
	MOVWF      R0+0
	MOVF       _v+1, 0
	MOVWF      R0+1
	MOVF       _v+2, 0
	MOVWF      R0+2
	MOVF       _v+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	CLRF       _counter2+0
	CLRF       _counter2+1
L_main6:
;MyProject_basil.c,49 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,50 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
	NOP
;MyProject_basil.c,51 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,52 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
	NOP
;MyProject_basil.c,32 :: 		for (x = 0; x < 1600; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,54 :: 		}
	GOTO       L_main0
L_main1:
;MyProject_basil.c,55 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,56 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,58 :: 		for (x = 0; x < 1600; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main9:
	MOVLW      128
	XORWF      _x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      6
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      64
	SUBWF      _x+0, 0
L__main57:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;MyProject_basil.c,59 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,60 :: 		portb.f2 =0;
	BCF        PORTB+0, 2
;MyProject_basil.c,61 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,62 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
	NOP
;MyProject_basil.c,63 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,64 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	NOP
	NOP
;MyProject_basil.c,58 :: 		for (x = 0; x < 1600; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,66 :: 		}
	GOTO       L_main9
L_main10:
;MyProject_basil.c,67 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,69 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,77 :: 		for(y = 0; y<6; y++){
	CLRF       _y+0
	CLRF       _y+1
L_main14:
	MOVLW      128
	XORWF      _y+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVLW      6
	SUBWF      _y+0, 0
L__main58:
	BTFSC      STATUS+0, 0
	GOTO       L_main15
;MyProject_basil.c,80 :: 		for (x = 0; x <= players[1]; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main17:
	MOVLW      128
	XORWF      _players+3, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       _x+0, 0
	SUBWF      _players+2, 0
L__main59:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
;MyProject_basil.c,81 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,82 :: 		portb.f2 =1;
	BSF        PORTB+0, 2
;MyProject_basil.c,83 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,84 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	NOP
	NOP
;MyProject_basil.c,85 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,86 :: 		delay_us(1800); }
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	NOP
	NOP
;MyProject_basil.c,80 :: 		for (x = 0; x <= players[1]; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,86 :: 		delay_us(1800); }
	GOTO       L_main17
L_main18:
;MyProject_basil.c,87 :: 		portd.f1 =1;
	BSF        PORTD+0, 1
;MyProject_basil.c,88 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,89 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,90 :: 		portd.f1 =0;
	BCF        PORTD+0, 1
;MyProject_basil.c,94 :: 		for (x = 0; x <= players[2]-players[1]; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main22:
	MOVF       _players+2, 0
	SUBWF      _players+4, 0
	MOVWF      R1+0
	MOVF       _players+3, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _players+5, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVF       _x+0, 0
	SUBWF      R1+0, 0
L__main60:
	BTFSS      STATUS+0, 0
	GOTO       L_main23
;MyProject_basil.c,95 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,96 :: 		portb.f2 =1;
	BSF        PORTB+0, 2
;MyProject_basil.c,97 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,98 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	NOP
	NOP
;MyProject_basil.c,99 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,100 :: 		delay_us(1800); }
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	NOP
	NOP
;MyProject_basil.c,94 :: 		for (x = 0; x <= players[2]-players[1]; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,100 :: 		delay_us(1800); }
	GOTO       L_main22
L_main23:
;MyProject_basil.c,101 :: 		portd.f1 =1;
	BSF        PORTD+0, 1
;MyProject_basil.c,102 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,103 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,104 :: 		portd.f1 =0;
	BCF        PORTD+0, 1
;MyProject_basil.c,110 :: 		for (x = 0; x <= players[3]-players[2]; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main27:
	MOVF       _players+4, 0
	SUBWF      _players+6, 0
	MOVWF      R1+0
	MOVF       _players+5, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _players+7, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _x+0, 0
	SUBWF      R1+0, 0
L__main61:
	BTFSS      STATUS+0, 0
	GOTO       L_main28
;MyProject_basil.c,111 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,112 :: 		portb.f2 =1;
	BSF        PORTB+0, 2
;MyProject_basil.c,113 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,114 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
	NOP
	NOP
;MyProject_basil.c,115 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,116 :: 		delay_us(1800); }
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	NOP
	NOP
;MyProject_basil.c,110 :: 		for (x = 0; x <= players[3]-players[2]; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,116 :: 		delay_us(1800); }
	GOTO       L_main27
L_main28:
;MyProject_basil.c,117 :: 		portd.f1 =1;
	BSF        PORTD+0, 1
;MyProject_basil.c,118 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,119 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,120 :: 		portd.f1 =0;
	BCF        PORTD+0, 1
;MyProject_basil.c,124 :: 		for (x = 0; x <= players[4]-players[3]; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main32:
	MOVF       _players+6, 0
	SUBWF      _players+8, 0
	MOVWF      R1+0
	MOVF       _players+7, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _players+9, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVF       _x+0, 0
	SUBWF      R1+0, 0
L__main62:
	BTFSS      STATUS+0, 0
	GOTO       L_main33
;MyProject_basil.c,125 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,126 :: 		portb.f2 =1;
	BSF        PORTB+0, 2
;MyProject_basil.c,127 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,128 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	NOP
	NOP
;MyProject_basil.c,129 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,130 :: 		delay_us(1800); }
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	NOP
	NOP
;MyProject_basil.c,124 :: 		for (x = 0; x <= players[4]-players[3]; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,130 :: 		delay_us(1800); }
	GOTO       L_main32
L_main33:
;MyProject_basil.c,131 :: 		portd.f1 =1;
	BSF        PORTD+0, 1
;MyProject_basil.c,132 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,133 :: 		msDelay(3000);
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,134 :: 		portd.f1 =0;
	BCF        PORTD+0, 1
;MyProject_basil.c,141 :: 		for (x = 0; x <= players[4]; x++) {
	CLRF       _x+0
	CLRF       _x+1
L_main37:
	MOVLW      128
	XORWF      _players+9, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVF       _x+0, 0
	SUBWF      _players+8, 0
L__main63:
	BTFSS      STATUS+0, 0
	GOTO       L_main38
;MyProject_basil.c,142 :: 		portb.f5 = 0;
	BCF        PORTB+0, 5
;MyProject_basil.c,143 :: 		portb.f2 =0;
	BCF        PORTB+0, 2
;MyProject_basil.c,144 :: 		portb.f4 = 1;
	BSF        PORTB+0, 4
;MyProject_basil.c,145 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
	NOP
;MyProject_basil.c,146 :: 		portb.f4 = 0;
	BCF        PORTB+0, 4
;MyProject_basil.c,147 :: 		delay_us(1800);
	MOVLW      5
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	NOP
	NOP
;MyProject_basil.c,141 :: 		for (x = 0; x <= players[4]; x++) {
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;MyProject_basil.c,149 :: 		}
	GOTO       L_main37
L_main38:
;MyProject_basil.c,150 :: 		portb.f5 = 1;
	BSF        PORTB+0, 5
;MyProject_basil.c,152 :: 		msDelay(3000);  }
	MOVLW      184
	MOVWF      FARG_msDelay_mscnt+0
	MOVLW      11
	MOVWF      FARG_msDelay_mscnt+1
	CALL       _msDelay+0
;MyProject_basil.c,77 :: 		for(y = 0; y<6; y++){
	INCF       _y+0, 1
	BTFSC      STATUS+0, 2
	INCF       _y+1, 1
;MyProject_basil.c,152 :: 		msDelay(3000);  }
	GOTO       L_main14
L_main15:
;MyProject_basil.c,165 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_ATD_init:

;MyProject_basil.c,168 :: 		void ATD_init(void){
;MyProject_basil.c,169 :: 		ADCON0=0x41;           // ON, Channel 0, Fosc/16== 500KHz, Dont Go
	MOVLW      65
	MOVWF      ADCON0+0
;MyProject_basil.c,170 :: 		ADCON1=0xCE;           // RA0 Analog, others are Digital, Right Allignment,
	MOVLW      206
	MOVWF      ADCON1+0
;MyProject_basil.c,171 :: 		TRISA=0x01;
	MOVLW      1
	MOVWF      TRISA+0
;MyProject_basil.c,172 :: 		}
L_end_ATD_init:
	RETURN
; end of _ATD_init

_ATD_read:

;MyProject_basil.c,173 :: 		unsigned int ATD_read(void){
;MyProject_basil.c,174 :: 		ADCON0=ADCON0 | 0x04;  // GO
	BSF        ADCON0+0, 2
;MyProject_basil.c,175 :: 		while(ADCON0&0x04);    // wait until DONE
L_ATD_read42:
	BTFSS      ADCON0+0, 2
	GOTO       L_ATD_read43
	GOTO       L_ATD_read42
L_ATD_read43:
;MyProject_basil.c,176 :: 		return (ADRESH<<8)|ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;MyProject_basil.c,177 :: 		}
L_end_ATD_read:
	RETURN
; end of _ATD_read

_msDelay:

;MyProject_basil.c,179 :: 		void msDelay(unsigned int mscnt) {
;MyProject_basil.c,182 :: 		for (ms = 0; ms < mscnt; ms++) {
	CLRF       R1+0
	CLRF       R1+1
L_msDelay44:
	MOVF       FARG_msDelay_mscnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay67
	MOVF       FARG_msDelay_mscnt+0, 0
	SUBWF      R1+0, 0
L__msDelay67:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay45
;MyProject_basil.c,183 :: 		for (cnt = 0; cnt < 155; cnt++);//1ms
	CLRF       R3+0
	CLRF       R3+1
L_msDelay47:
	MOVLW      0
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay68
	MOVLW      155
	SUBWF      R3+0, 0
L__msDelay68:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay48
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
	GOTO       L_msDelay47
L_msDelay48:
;MyProject_basil.c,182 :: 		for (ms = 0; ms < mscnt; ms++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject_basil.c,184 :: 		}
	GOTO       L_msDelay44
L_msDelay45:
;MyProject_basil.c,185 :: 		}
L_end_msDelay:
	RETURN
; end of _msDelay

_usDelay:

;MyProject_basil.c,187 :: 		void usDelay(unsigned int uscnt) {
;MyProject_basil.c,189 :: 		for (us = 0; us < uscnt; us++) {
	CLRF       R1+0
	CLRF       R1+1
L_usDelay50:
	MOVF       FARG_usDelay_uscnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__usDelay70
	MOVF       FARG_usDelay_uscnt+0, 0
	SUBWF      R1+0, 0
L__usDelay70:
	BTFSC      STATUS+0, 0
	GOTO       L_usDelay51
;MyProject_basil.c,190 :: 		asm NOP; // Takes 0.5us
	NOP
;MyProject_basil.c,191 :: 		asm NOP; // Takes 0.5us
	NOP
;MyProject_basil.c,189 :: 		for (us = 0; us < uscnt; us++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject_basil.c,192 :: 		}
	GOTO       L_usDelay50
L_usDelay51:
;MyProject_basil.c,193 :: 		}
L_end_usDelay:
	RETURN
; end of _usDelay
