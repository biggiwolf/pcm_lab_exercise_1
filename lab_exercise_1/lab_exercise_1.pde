/*
PCM 2016-2017

First Processing Exercise

Using the provided audio file (01 PCM Rock Sample.mp3), do the following:

1. Display the song's MetaInfo [100 XP]

2. Implement (using what you learned in theoretical classes) functions that:
    - Reverse the music  [100 XP]
    - Apply fade-in and fade-out effects [100 XP]
    - Apply a low-pass filter    [100 XP]

 (Hint: to make it noticeable you probably will need to take into account
 considerably more than just two or three adjacent samples)

3. Implement other sound effects. Be creative and show us what you can do! [200 XP]*/

import ddf.minim.*;

Minim minim;
AudioPlayer song;
MultiChannelBuffer songBuffer;

void setup(){
  //code
  minim = new Minim(this);
  song = minim.loadFile("01_PCM_Rock_Sample.mp3");
  println("song length: " + song.length());
  //song.play();
  
  //MultiChannelBuffer songBuffer = new MultiChannelBuffer(2,1024);
  songBuffer = new MultiChannelBuffer(2,1024);
  minim.loadFileIntoBuffer("01_PCM_Rock_Sample.mp3",songBuffer);
  
  println("buffersize: " + songBuffer.getBufferSize() + ", channels: " + songBuffer.getChannelCount());
  
  AudioSample reversedResult = reverse();
  
  reversedResult.trigger();
  
  println("reversed length: " + reversedResult.length());
}

void draw(){
   //code 
}

void stop(){
  //code
  song.close();
  minim.stop();
  
  super.stop();
}

AudioSample reverse(){
  float[] leftOriginal = new float[songBuffer.getBufferSize()];
  float[] leftReversed = new float[songBuffer.getBufferSize()];
  float[] rightOriginale = new float[songBuffer.getBufferSize()];
  float[] rightReversed = new float[songBuffer.getBufferSize()];
  
  for(int i = 0; i < songBuffer.getBufferSize(); i++){
   leftReversed[i] = songBuffer.getSample(0,songBuffer.getBufferSize()-i-1);
   rightReversed[i] = songBuffer.getSample(1,songBuffer.getBufferSize()-i-1);
  }
  
  AudioSample reverse = minim.createSample(leftReversed, rightReversed, song.getFormat());
  return reverse;
}

//probably more functions here