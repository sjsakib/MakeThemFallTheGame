class Timer {
  int t;
  int start;
  boolean isSet;
  
  Timer() {
    isSet  = false;
  }
  void set(int time) {
    isSet  = true;
    t = time;
    start = millis();
  }
  
  void reset() {
    isSet  = false;
    t = 0;
    start = 0;
  }
  
  int remaining() {
    int passed = millis() - start;
    if(passed<=t)  {
      return t-passed;
    } else return 0;
  }
  
  boolean isFinished() {
    int passed = millis() - start;
    if(passed>t) {
      return true;
    } else return false;
  }
}

