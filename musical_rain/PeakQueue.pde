class PeakQueue {
  int deviation = 30; // Within how many ms would be considered on Peak
  
  int capacity = 50;
  int queue[] = new int[capacity];
  int front = 0;
  int end = 0;
  int size = 0;
  int last_Peak;
    
  public PeakQueue(PeakDetector bd) {
    bd.addListener(     
      new Bead()
       {
           protected void messageReceived(Bead b)
           {
             push_back(millis());
           }
       }
    );
  }
  
  // Give the time of next Peak
  public int next() {
    pop_invalids();
    return queue[front] - millis();
  }
  
  // Give an array of times of Peak within the set period
  public int[] nexts() {
    if (size == 0) return new int[1];
    pop_invalids();
    int result[] = new int[size];
    
    for (int i = front, count=0; i != end; i = increase_index(i), ++count) {
      result[count] = queue[i] - millis(); 
      
      //print(result[count].data+"\n");
    }
    return result;
  }
  
  public void holdGap() {
    int k;
    for (int i = front, count=0; i != end; i = increase_index(i), ++count) {
      k = i+1;
      if (k > end) k = 0;
      println((queue[i] - millis()) - (queue[k] - millis()));
      if ((queue[i] - millis()) - (queue[k] - millis()) < 0) {
        checkGap = true;
      } else {
        checkGap = false;
      }
    }
  }
  
  public boolean onPeak() {
    return next() - millis() < deviation || millis() - last_Peak < deviation; 
  }
  
  private void push_back(int time) {
    queue[end] = time + bd.forward;
    end = increase_index(end);
    ++size;
  }

  
  private void pop_invalids() {
    while (size > 0 && millis() > queue[front]) {
       last_Peak = queue[front];
       front = increase_index(front);
       --size;
    }
  }

  private int increase_index(int i) {
    return (i+1)%capacity;
  }
  
}