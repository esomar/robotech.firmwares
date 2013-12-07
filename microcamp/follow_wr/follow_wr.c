#include  <motor.h>
#include <sleep.h>
#include <sound.h>
#include <analog.h>

const int THRESHOLD = 800;

void myforward(int power){
motor(1, power );
motor(2, power *0.9);
}


void m_left(int speed)
{
	motor(1,speed);
	motor(2,-speed/2*0.9);
}
void m_right(int speed)
{
	motor(1,-speed/2);
	motor(2,speed*0.9);
}


int wtf(int turned_left){
if(turned_left==0) s_right(50);
else s_left(100);
myforward(50);
sleep(30);
}

int avg_analog (int port){
  int sum = 0;

  for (int i=0; i< 10; i++)
      sum += analog(port);

  return sum / 10;

}


int main(){
	
	int turned_left = 0;
	while(1){
        unsigned int sensor_r = avg_analog(0);
		unsigned int sensor_l = avg_analog(1);
		//unsigned int sensor_m = avg_analog(2);
		//if(sensor_r<THRESHOLD && sensor_l<){
		//	myforward(50);
		//}
		if (sensor_r < THRESHOLD && sensor_l <THRESHOLD)
		    wtf(turned_left);
		  
        else if (sensor_r > THRESHOLD && sensor_l <= THRESHOLD ){
		    s_left(50);
			turned_left = 1;
			}
        else if (sensor_l > THRESHOLD && sensor_r <= THRESHOLD ){
		    s_right(50);
			turned_left = 0;
			}
        else 
		  myforward(50);

        //forward(50);
		//sleep(100);

		//if (sensor_m < THRESHOLD)
		//   sound( 100, 10);
		   



	}
	return 0;
}
