import ddf.minim.*;

Minim minim;
AudioPlayer song;

    
void setup(){
  size(512,200);
  //song.shiftGain(-80.0, 0, 5000); //fadein
 
  //cleanSignal.play();
   minim = new Minim(this);
   //song = minim.loadFile("01_PCM_Rock_Sample.mp3");
   MultiChannelBuffer songBuffer = new MultiChannelBuffer(2,1024);
   minim.loadFileIntoBuffer("01_PCM_Rock_Sample.mp3",songBuffer);
  
   AudioSample lowpassresult = lowpassing(songBuffer);
  
   lowpassresult.trigger();

}

void draw(){
  background(0);
  stroke(100,200,255);
  for (int i = 0; i < song.bufferSize() - 1; i++){
    line(i, 50 + song.left.get(i)*100, i+1, 50 + song.left.get(i+1)*100);
    line(i, 150 + song.right.get(i)*100, i+1, 150 + song.right.get(i+1)*100);
  }
}


void stop(){
  song.close();
  minim.stop();
  
  super.stop();
}

//class Filter{
//float k = 0.5; // low pass alpha level
//float cleanSignal;

//Filter() {} //default constructor
//Filter(float kv) {k = kv;} //changing the k value

//float lowpass(float signal)
//{
//  float oldSignal = cleanSignal;
//  cleanSignal = oldSignal + k*(signal - oldSignal);
//  return cleanSignal;
//}
//}

AudioSample lowpassing(MultiChannelBuffer toLowpass){
  float[] leftLowpassed = new float[toLowpass.getBufferSize()];
  float[] rightLowpassed = new float[toLowpass.getBufferSize()];
  
  for(int i = 0; i < toLowpass.getBufferSize(); i++){
   leftLowpassed[i+1] =  leftlowpassed[i] + 0.5 * (toLowpass[i] - leftLowpassed[i]); 
   rightLowpassed[i+1] =  rightlowpassed[i] + 0.5 * (toLowpass[i] - rightLowpassed[i]); 
  }
  
  AudioSample lowpassed = minim.createSample(leftLowpassed, rightLowpassed, song.getFormat());
  return lowpassed;
}


 