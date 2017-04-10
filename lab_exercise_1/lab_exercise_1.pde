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
AudioBuffer left;
AudioBuffer right;
AudioBuffer mono;

void setup(){
  //code
  minim = new Minim(this);
  //song = minim.loadFile("01_Baptized.mp3", 248555);
  song = minim.loadFile("01_PCM_Rock_Sample.mp3");
  println("size song: " + song.length());
  println("song buffersize: " + song.bufferSize());
  AudioSample reverse = reverse();

  reverse.trigger();
  print("reversed");
  float[] reverse3 = new float[25000];
  AudioSample original = minim.loadSample("01_Baptized.mp3");
  
  println("size original audiosample: " + original.length());
  println("original buffersize: " + original.bufferSize());
  
  //original.trigger();
  for(int i = 0; i < 25000;i++){
    reverse3[i] = i % 1000;
    
  }
  //reverse.trigger();
  AudioSample reverse2 = minim.createSample(reverse3, song.getFormat());
  println("reverse2 size: " + reverse2.length());
  //reverse2.trigger();
  println("triggered");
  //song.play();
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
  AudioSample reverse;
  if(song.type() == Minim.MONO){
    //if mono left and right contain the same sample
    mono = song.left;
    print("mono");
    print("song left size: " + mono.size());
    float[] originalMono = left.toArray();
    float[] reverseMono = left.toArray();
    print("arraymono size: " + reverseMono.length);
    
    for(int i = 0; i < mono.size(); i++){
       reverseMono[i] = originalMono[originalMono.length-i-1];
    }
    
    reverse = minim.createSample(reverseMono, song.getFormat());
  }
  else{
    println("stereo");
    left = song.left;
    println("!!!! left 0: " + left.get(1000));
    println("left buffersize: " + song.bufferSize());
    println("song left size: " + left.size());
    right = song.right;
    println("song right size: " + right.size());
    float[] originalLeft = left.toArray();
    float[] originalRight = right.toArray();
    float[] reverseLeft = left.toArray();
    float[] reverseRight = right.toArray();
    println("song left size array: " + reverseLeft.length + " song right size array: " + reverseRight.length);
    for(int i = 0; i < left.size(); i++){
       reverseLeft[i] = originalLeft[originalLeft.length-i-1];
       reverseRight[i] = originalRight[originalRight.length-i-1];
       //print(i + " = " + reverseLeft[i]);
    }
    //left.get(248556);
    reverse = minim.createSample(reverseLeft, reverseRight, song.getFormat());
    println("reverse size: " + reverse.length());
    
    println("song left 50: " + song.left.get(1000));
    println("song left left 50: " + song.left.get(1000));
    
  }
  return reverse;
}

//probably more functions here