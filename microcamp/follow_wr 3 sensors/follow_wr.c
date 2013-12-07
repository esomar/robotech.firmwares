#include <motor.h>
#include <sleep.h>
#include <sound.h>
#include <analog.h>

const int THRESHOLD = 800;

void myforward(int power){
motor(1, power );
motor(2, power /3);
}

int avg_analog (int port){
  int sum = 0;
  for (int i=0; i< 10; i++)
      sum += analog(port);
  return sum / 10;
}

#define OOO 0
#define OOX 1
#define OXO 2
#define OXX 3
#define XOO 4
#define XOX 5
#define XXO 6
#define XXX 7
int main(){
	
	int turned_left = 0;
	while(1){
	    unsigned char state;
        state = 0;
		for (int i = 0 ; i <3 ; i++)
		   state |= (avg_analog(i) < THRESHOLD ) << i;
        
        switch (state){
		    case  OOO: s_left(100); sleep (30); myforward(30); break;
			case  OOX: s_right(100);break;
			case  OXO: myforward(50);sound(500, 10); break;
			case  OXX: s_right(50);break;
			case  XOO: s_left(100); break;
			case  XOX: myforward(50); break;
			case  XXO: s_left(50); break;
			case  XXX: s_right(100); sleep(30); myforward(30);sound(100, 200); break;
			default : break;
			}		
	}
	return 0;
}
