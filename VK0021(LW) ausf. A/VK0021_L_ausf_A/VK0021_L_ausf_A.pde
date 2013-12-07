int rKettenFwd=6;
int rKettenRwd=7;
int lKettenFwd=9;
int lKettenRwd=8;

int i =0; 

int LEDPIN = 13;

const int MAX_CMD_LEN = 20;

void setup() {
  pinMode(rKettenFwd, OUTPUT);
  pinMode(rKettenRwd, OUTPUT);
  pinMode(lKettenFwd, OUTPUT);
  pinMode(lKettenRwd, OUTPUT);
 
  Serial.begin(115200);
  Serial.println("Ready to rock");
}

void readln( char buffer[] ) {
  char c;  
  int i = 0;  
  int quiet = 0;
  while( true ) {
    if ( Serial.available() ) {
      quiet = 0;
      c = Serial.read();
      if ( c == 13 ) {
        Serial.read(); 
        break;
      }
      if ( c == 10) {
        break;
      }
      buffer[i++] = c;    
      if ( i == (MAX_CMD_LEN-1) ) break;
    } else {
      if ( quiet > 2 ) break;
      quiet ++;
    }
    delay(2); // short delay         
  } 
  buffer[i] = NULL;     
}

void skipws(char * & c){
while (*c==' ')
  c++;
}

int atoi(char *c, char * & result){
  int temp=0;
  while (*c && ((*c)>='0' || (*c<='9'))){
    temp = temp * 10 + *c - '0';
    c++;
  }
  result = c;
  return temp;
}

void loop() {
  int temp = 0;
  char *c = 0;
  char *t = 0;
  int pin = 0;
  char cmd[MAX_CMD_LEN+1];

if (Serial.available()!=0){
  readln(cmd);

  if (strcmp(cmd, "on")==0)
    digitalWrite(LEDPIN, HIGH);
  else  
  if (strcmp(cmd, "off")==0)
    digitalWrite(LEDPIN, LOW);

  else
  {
    c = cmd;

    if (*c=='r')
      pin = 0;
      else
    if (*c=='l')
      pin = 1;
            
    c++;
    skipws(c);  
    temp = atoi(c, t);
    
    if (pin==0){
      if (temp >150){
        Serial.println(temp);
        analogWrite(rKettenRwd, 0);
        analogWrite(rKettenFwd, temp);;
      } else
      if (temp<110){
        Serial.println(temp);
        analogWrite(rKettenFwd, temp*2);
        analogWrite(rKettenRwd, 255);;
      }
      else   {
        Serial.println("rechts ketten halt");
        analogWrite(rKettenFwd, 0);
        analogWrite(rKettenRwd, 0);;
      }}
      else
     if (pin==1){
      if (temp >150){
        Serial.println(temp);
        analogWrite(lKettenRwd, 0);
        analogWrite(lKettenFwd, temp);;
      } else
      if (temp<110){
        Serial.println(temp);
        analogWrite(lKettenFwd, temp*2);
        analogWrite(lKettenRwd, 255);;
      } 
      else   {
        Serial.println("links ketten halt");
        analogWrite(lKettenFwd, 0);
        analogWrite(lKettenRwd, 0);;
      }
      }
      else
      {
          Serial.println("Nicht Ferstennung");
          Serial.println(cmd);
          
      }
  }
    
}  
}
 


