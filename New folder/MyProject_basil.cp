#line 1 "C:/Users/20191073/Desktop/New folder/MyProject_basil.c"
int x;
int players[5];
int counter;
int counter2;
void msDelay (unsigned int mscnt);
int sen1;
float v;
void ATD_init(void);
unsigned int ATD_read(void);
int k;
int y;



void main() {
TRISB = 0b00000000;
TRISD = 0b00000000;
ATD_init();

msDelay(50);




portb.f2 =1;
portb.f5 =1;
portb.f1 =0;
portd.f1 =0;


msDelay(3000);
for (x = 0; x < 1600; x++) {
 portb.f2 =1;
 portb.f5 =0;

 k = ATD_read();
 v = ((k*4.8)/1023);
 if(v>=1.5 && counter2==0){ counter2++;
 counter = counter+1;
 players[counter] = x;
 portb.f5 = 1;
 portb.f1 =1;
 msDelay(1000);
 portb.f5 = 0;
 portb.f1 =0;}

 if(v<1.2){counter2=0;}

portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800);

}
portb.f5 = 1;
msDelay(3000);

for (x = 0; x < 1600; x++) {
portb.f5 = 0;
 portb.f2 =0;
 portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800);

}
 portb.f5 = 1;

 msDelay(3000);







 for(y = 0; y<6; y++){


 for (x = 0; x <= players[1]; x++) {
portb.f5 = 0;
 portb.f2 =1;
 portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800); }
portd.f1 =1;
portb.f5 = 1;
msDelay(3000);
portd.f1 =0;



 for (x = 0; x <= players[2]-players[1]; x++) {
portb.f5 = 0;
 portb.f2 =1;
 portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800); }
portd.f1 =1;
 portb.f5 = 1;
 msDelay(3000);
 portd.f1 =0;





 for (x = 0; x <= players[3]-players[2]; x++) {
portb.f5 = 0;
 portb.f2 =1;
 portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800); }
portd.f1 =1;
 portb.f5 = 1;
 msDelay(3000);
 portd.f1 =0;



 for (x = 0; x <= players[4]-players[3]; x++) {
portb.f5 = 0;
 portb.f2 =1;
 portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800); }
portd.f1 =1;
 portb.f5 = 1;
 msDelay(3000);
 portd.f1 =0;






 for (x = 0; x <= players[4]; x++) {
portb.f5 = 0;
 portb.f2 =0;
 portb.f4 = 1;
delay_us(1800);
portb.f4 = 0;
delay_us(1800);

}
 portb.f5 = 1;

 msDelay(3000); }
#line 165 "C:/Users/20191073/Desktop/New folder/MyProject_basil.c"
}


void ATD_init(void){
 ADCON0=0x41;
 ADCON1=0xCE;
 TRISA=0x01;
}
unsigned int ATD_read(void){
 ADCON0=ADCON0 | 0x04;
 while(ADCON0&0x04);
 return (ADRESH<<8)|ADRESL;
}

void msDelay(unsigned int mscnt) {
 unsigned int ms;
 unsigned int cnt;
 for (ms = 0; ms < mscnt; ms++) {
 for (cnt = 0; cnt < 155; cnt++);
 }
}

void usDelay(unsigned int uscnt) {
 unsigned int us;
 for (us = 0; us < uscnt; us++) {
 asm NOP;
 asm NOP;
 }
}
