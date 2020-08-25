#include <array.au3>
#include <file.au3>


;array of all file's in the input folder
$files = _FileListToArray(@scriptdir & '\input', '*', 1, true)
_ArrayDelete($files, 0)


for $i = 0 to ubound($files) - 1

   $split = stringsplit($files[$i], '\')
   $filename = $split[$split[0]]

   ;median
   $command = 'magick ' & $files[$i] & ' -statistic median 8x8 median.png'
   runwait(@ComSpec & " /c " & $command, "", @SW_HIDE)

   ;detect outlines
   $command = 'magick median.png -canny 10x1+10%+5% outline.png'
   runwait(@ComSpec & " /c " & $command, "", @SW_HIDE)

   ;detect lines
   $command = 'magick outline.png -hough-lines 20x20+100 lines.mvg'
   runwait(@ComSpec & " /c " & $command, "", @SW_HIDE)

   ;parse line angles
   local $angles[180]	; score of various angles
   $lines = FileReadToArray('lines.mvg')
   if ubound($lines) > 3 then
	  for $j = 3 to ubound($lines) - 1
		 $split = stringsplit($lines[$j], ' ', 2)
		 $angle    = $split[6]
		 $distance = $split[7]

		 ;angle scores are based on line length
		 $angles[$angle] += $distance
	  next
   else
	  ;copy img to output unchanged?

   endif

   ;find which angle has highest score
   $best_index = 0
   $best_score = 0
   for $j = 0 to 179
	  if $angles[$j] > $best_score then
		 $best_index = $j
		 $best_score = $angles[$j]
	  endif
   next

   ;apply rotation to correct skew
   $skew = 90 - $best_index
   $command = 'magick ' & $files[$i] & ' -virtual-pixel white +distort SRT ' & $skew & ' ' & @scriptdir & '\output\' & $filename
   runwait(@ComSpec & " /c " & $command, "", @SW_HIDE)

next

