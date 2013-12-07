// -*- mode: c -*-
#include "Servo.h"

// int i =0; 

/***
 * Pin addresses
 */
int LEDPIN = 13;
int ENGINEREV = 2; //rev
int ENGINEPWM = 3; // pwm

int STEER = 10;

int CAMHPIN = 9;
int CAMVPIN = 11;

/***
 * Movement parameters
 */
const int SAFE_MIN = 10;
const int SAFE_MAX = 160;

/***
 * Protocol parameters:
 * - MAX_CMD_LEN - maximum length of command
 *     Please, make sure that new commands will not exceed this limit!
 * - MAX_QUIET_TIME - how much periods will reader wait before exiting
 * - READER_PERIOD_TIME - length of reader time periods (see prev. parameter)
 */
const int MAX_CMD_LEN = 20;
const int MAX_QUIET_TIME = 2;
const int READER_PERIOD_TIME = 2;

/***
 * Model parameters
 */
const long SERIAL_SPEED = 115200;

Servo servos[3];

/***
 * HOW TO ADD AN ACTION INTO PROTOCOL
 *
 * 1. Add a function which perform this action (its signature should be: void(&action)(int) )
 *    - its argument is an argument given with command
 *    - if action don't use argument, just ignore the parameter
 * 2. Increase command count constant CMD_COUNT
 * 3. Add an entry into mapping[] as {"<cmd>", <function>}
 *    - here <cmd> is command in protocol (its length should be less than 20)
 *    - <function> is a function name from p.1
 * 4. If your action should use two or more parameters, or check for nonexistence of parameter, 
 *    please feel free to email gltronred@gmail.com
 */

/***
 * Actions to perform
 */
void ledOn(int){
  digitalWrite(LEDPIN, HIGH);
}

void ledOff(int){
  digitalWrite(LEDPIN, LOW);
}

void full(int){
  digitalWrite(ENGINEPWM, LOW);
  digitalWrite(ENGINEREV, HIGH);
}

void goHV(int pin, int arg){
  if (arg>=SAFE_MIN && arg<=SAFE_MAX)
    servos[pin].write(arg);
  else{
    Serial.print("Not safe angle: ");
    Serial.println(arg);
  }
}

void goH(int arg){
  goHV(0,arg);
}

void goV(int arg){
  goHV(1,arg);
}

void goE(int arg){
  int converted = abs(arg-90)/90.0*255;

  Serial.print("goE: ");
  Serial.println(arg);

  int enginerev=0;
  int enginepwm=0;

  if (arg>90){
    enginepwm=converted;
  }else if (arg<90){
    enginerev = 1;
    enginepwm=255-converted;
  }

  digitalWrite(ENGINEREV, enginerev);
  analogWrite(ENGINEPWM, enginepwm);
}

void goS(int arg){
goHV(2, arg);
}

/***
 * Map commands to actions
 */
typedef struct {
  char cmd[20];
  void (&action)(int);
} mapentry;


mapentry mapping[]={{"on",ledOn},
			     {"off",ledOff},
			     {"full",full},
			     {"h",goH},
			     {"v",goV},
			     {"e",goE},
			     {"s",goS}};

const int CMD_COUNT = sizeof(mapping)/sizeof(mapping[0]);

/***
 * Main program begins here
 */

void setup() {
  pinMode(ENGINEREV, OUTPUT);
  pinMode(ENGINEPWM, OUTPUT);
  servos[0].attach(CAMHPIN, 450, 2450); 
  servos[1].attach(CAMVPIN, 450, 2450);
  servos[2].attach(STEER, 450, 2450);

  Serial.begin(SERIAL_SPEED);
  Serial.println("Ready to rock");
  Serial.println(CMD_COUNT);
  Serial.println("Commands total");
  
}


/***
 * Reads a command into buffer[]
 * Command is one line, followed by \x0d\x0a
 */
void readln( char buffer[] ) {
  char c;
  int i=0;
  int quiet=0; // quietness periods
  int exit=0; // exit loop if 1
  while (exit==0 && quiet++<=MAX_QUIET_TIME && i<MAX_CMD_LEN){
    if (Serial.available()){
      quiet=0; // not quiet
      c=Serial.read();
      switch(c){
      case '\r':
	Serial.read();
	exit=1; // this line and next line could be removed, because we will not break, but go to '\n' case
	break;  // but with these lines code is more clear
      case '\n':
	exit=1;
	break;
      default:
	buffer[i++]=c;
	break;
      }
    }
    delay(READER_PERIOD_TIME);
  }
  buffer[i]=NULL;
}

int skipws(const char* str, int start){
  int i=start;
  while (str[i] && str[i]==' ')i++;
  return i;
}

int getSpaceIndex(const char* str, int start){
  int i=start;
  while (str[i] && str[i]!=' ')i++;
  return i;
}

int getParam(char* param, const char* str, int start){
  int bound=getSpaceIndex(str,start);
  memset(param, 0, 20);
  strncpy(param,str+start,bound);
  return skipws(str,start+bound);
}

// TODO: ask, whether the commands could get two or more parameters
// TODO: think about speed of working (should we use binary search here?)
void parseCmd(const char* str, int& index, int& arg){
  char cmd[20];
  char argument[20];

  int end1=getParam(cmd,str,0);
  int end2=getParam(argument,str,end1);

  index=-1; // not found;
  while(index<CMD_COUNT && strcmp(cmd,mapping[index].cmd)!=0){
    index++;
  }
  if (index==CMD_COUNT)
    index=-1;

  arg=atoi(argument);
}

/***
 * Main loop
 */
void loop() {
  char cmd[MAX_CMD_LEN+1];

  if (Serial.available()!=0){
    readln(cmd);

    int index=-1; // command index in mapping table
    int arg=-1; // command argument
    parseCmd(cmd,index,arg);

    if (index==-1){
      Serial.print("UNKNOWN CMD: ");
      Serial.println(cmd);
    }else{
      Serial.print("Got command: ");
      Serial.print(mapping[index].cmd);
      Serial.print("(");
      Serial.print(arg);
      Serial.println(")");

      mapping[index].action(arg);
    }
  }
}
