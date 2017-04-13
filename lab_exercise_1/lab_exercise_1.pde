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
//MultiChannelBuffer songBuffer;
//MultiChannelBuffer reversedSongBuffer;
AudioMetaData meta;

void setup(){
  minim = new Minim(this);
  song = minim.loadFile("01_PCM_Rock_Sample.mp3");
  
  //metadata
  meta = song.getMetaData();
  size(512, 512);
  
  textFont(createFont("Serif", 24));
  
  //reverse
  MultiChannelBuffer songBuffer = new MultiChannelBuffer(2,1024);
  minim.loadFileIntoBuffer("01_PCM_Rock_Sample.mp3",songBuffer);
  
  println("buffersize: " + songBuffer.getBufferSize() + ", channels: " + songBuffer.getChannelCount());
  
  //MultiChannelBuffer reversedResult = reverse(songBuffer);
  
  //MultiChannelBuffer reversedReversedResult = reverse(reversedResult);
  
  //AudioSample original = minim.createSample(songBuffer.getChannel(0), songBuffer.getChannel(1), song.getFormat());
  //AudioSample reverse = minim.createSample(reversedReversedResult.getChannel(0), reversedReversedResult.getChannel(1), song.getFormat());
  
  //original.trigger();
  
  //AudioSample reverse = reverse(songBuffer);
  
  //println("original lenght: " + songBuffer.getBufferSize());
  //println("reversed length: " + reversedResult.getBufferSize());
  //println("reversed reversed length: " + reversedReversedResult.getBufferSize());
  
  AudioSample copy = copy(1);
  copy.trigger();
}

void draw(){
   //metadata
  int ys = 25;
  int yi = 26;
  background(0);
  int y = ys;
  text("File Name: " + meta.fileName(), 5, y);
  text("Length (in milliseconds): " + meta.length(), 5, y+=yi);
  text("Title: " + meta.title(), 5, y+=yi);
  text("Author: " + meta.author(), 5, y+=yi); 
  text("Album: " + meta.album(), 5, y+=yi);
  text("Date: " + meta.date(), 5, y+=yi);
  text("Comment: " + meta.comment(), 5, y+=yi);
  text("Lyrics: " + meta.lyrics(), 5, y+=yi ); 
  text("Track: " + meta.track(), 5, y+=yi);
  text("Genre: " + meta.genre(), 5, y+=yi);
  text("Copyright: " + meta.copyright(), 5, y+=yi);
  text("Disc: " + meta.disc(), 5, y+=yi);
  text("Composer: " + meta.composer(), 5, y+=yi);
  text("Orchestra: " + meta.orchestra(), 5, y+=yi);
  text("Publisher: " + meta.publisher(), 5, y+=yi);
  text("Encoded: " + meta.encoded(), 5, y+=yi);
}

void stop(){
  //code
  song.close();
  minim.stop();
  
  super.stop();
}

/*
MultiChannelBuffer reverse(MultiChannelBuffer toReverse){
   MultiChannelBuffer reversedSongBuffer = new MultiChannelBuffer(1,1);
   reversedSongBuffer.set(toReverse);
   
   for(int i = 0; i < toReverse.getBufferSize(); i++){
     reversedSongBuffer.setSample(0, i, toReverse.getSample(0,toReverse.getBufferSize()-i-1));
     reversedSongBuffer.setSample(1, i, toReverse.getSample(1,toReverse.getBufferSize()-i-1));
   }
   
   println("reversedSongBuffer size: " + reversedSongBuffer.getBufferSize());
   
   //AudioSample reverse = minim.createSample(reversedSongBuffer.getChannel(0), reversedSongBuffer.getChannel(1), song.getFormat());
   //return reverse;
   
   return reversedSongBuffer;
}
*/


AudioSample reverse(MultiChannelBuffer toReverse){
  float[] leftReversed = new float[toReverse.getBufferSize()];
  float[] rightReversed = new float[toReverse.getBufferSize()];
  
  for(int i = 0; i < toReverse.getBufferSize(); i++){
   leftReversed[i] = toReverse.getSample(0,toReverse.getBufferSize()-i-1);
   rightReversed[i] = toReverse.getSample(1,toReverse.getBufferSize()-i-1);
  }
  
  AudioSample reverse = minim.createSample(leftReversed, rightReversed, song.getFormat());
  return reverse;
}

AudioSample copy(int o){
  AudioPlayer original;
  
  MultiChannelBuffer originalBuffer = new MultiChannelBuffer(2,1024);
  minim.loadFileIntoBuffer("01_PCM_Rock_Sample.mp3",originalBuffer);
  
  original = minim.loadFile("01_PCM_Rock_Sample.mp3", originalBuffer.getBufferSize());
  
  float[] leftChannel = original.left.toArray();
  float[] rightChannel = original.right.toArray();
  
  println("left channel size: " + leftChannel.length + " , right channel size: " + rightChannel.length);
  
  for(int i = 0; i < 2000; i++){
   println("i = " + i + " left channel: " + original.left.get(i) + " , right channel: " + original.right.get(i)); 
  }
  
  AudioSample copy = minim.createSample(leftChannel, rightChannel, song.getFormat());
  
  return copy;
  
}


//probably more functions here