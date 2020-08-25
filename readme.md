autoit script utilizing imagemagick that can correct skews for images containing text, and automatically crop to the text.
  
![output result](https://raw.githubusercontent.com/lllllll-llll-llllll/text-skew-detection-correction/master/github/SAMPLE.png)  
  
examples:  
  'input' folder contains some skewed images.  
  'output' folder contains the resulting corrected images.  
  
theory of operation:  
images containing text with a median filter applied creates long blobs, which we can outline, then form lines based on, and figure out the angles of these lines, the strongest of which is used to apply a corrective rotation.  
 

  
  
  
  
  
  
