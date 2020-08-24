this is an autoit script utilizing imagemagick that can detect and correct skewed batches of images containing text.
  
the degree of skew correction is only to the nearest integer of a degree. it does not check if the resulting image's text is upside down as of now, so if the input image's text is mostly upside down the output image's text will also.  
  
if you want to see examples of it:  
  'input' folder contains some skewed images.  
  'output' folder contains the resulting corrected images.  
  
basic idea:  
  images containing text with a median filter applied creates long blobs, which can be used to detect lines and figure out the angles of these lines, which is what is used to apply a corrective rotation.  
  
  
  
  
  
how it works:
  - #.png > median filter > canny edge detection > hough line transform > lines.mvg
  - parse line angles/distances from lines.mvg
  - angle strength grows by its distance
  - find strongest angle, apply rotation based on it
  - save that corrected image in the output folder
  - repeat for all images in the input folder
  
  
  
  
  
  
  
