echo "Various steps to get the final svg format output."

echo "01 - thresholding"
python ./Src/01-ResizeThreshold.py --inDir "./Input" --outDir "../drive/MyDrive/Src/temp/01" --ResizeFlag False

echo "02 - png2ppm"
inputdir='../drive/MyDrive/Src/temp/01/'
outputdir='../drive/MyDrive/Src/temp/02/'
if [ ! -e $"$outputdir" ]
then
   mkdir $"$outputdir"
fi
for g in $inputdir*
do
    FILE1=$(basename "${g}")
    FILE1="${FILE1%%.*}"
    convert $inputdir$(basename "${g}") $"$outputdir/$FILE1.ppm"
done

echo "03 - ppm2svg"
inputdir='../drive/MyDrive/Src/temp/02/'
outputdir='../drive/MyDrive/Src/temp/03/'
if [ ! -e $"$outputdir" ]
then
   mkdir $"$outputdir"
fi
for g in $inputdir*
do
    FILE1=$(basename "${g}")
    FILE1="${FILE1%%.*}"
    echo $"$outputdir$FILE1.svg"
    autotrace -centerline -color-count 2 -output-file $"$outputdir/$FILE1.svg" -output-format SVG $inputdir$(basename "${g}")
done

echo "04 - svg - Cleaning"
python ./Src/04-svgCleaning.py --inDir "../drive/MyDrive/Src/temp/03/" --outDir "../drive/MyDrive/Src/temp/04"

echo "05 - svg - 1M - 1Path"
python ./Src/05-svg1M1Path.py --inDir "../drive/MyDrive/Src/temp/04/" --outDir "../drive/MyDrive/Src/temp/05"

# echo "06 - svg - SmallPathRemoval"
# python ./Src/06-SmallPathRemoval.py --inDir "../drive/MyDrive/Src/temp/05/" --outDir "../drive/MyDrive/Src/temp/06"

# echo "07 - svg - longest path first"
# python ./Src/07-LongestPathFirst.py --inDir "../drive/MyDrive/Src/temp/05/" --outDir "../drive/MyDrive/Src/temp/07"

# echo "08 - svg - reorder paths: nearest starting point."
# python ./Src/08-ReorderPath-Mat.py --inDir "../drive/MyDrive/Src/temp/07/" --outDir "../drive/MyDrive/Src/temp/08"

echo "09 - svg file cleaning"
python ./Src/09-svgCleaning.py --inDir "../drive/MyDrive/Src/temp/05/" --outDir "../drive/MyDrive/Src/temp/09"

echo "10 - svg - TUBerlin style"
# python ./Src/10-TUBerlinStyleSvg.py --inDir "../drive/MyDrive/Src/temp/09/" --outDir "../drive/MyDrive/Output/svg" --refSVG "./Src/Ref-svg.svg" --imgSize 1024 --strokeWidth 1
python ./Src/10-my_svg.py --inDir "../drive/MyDrive/Src/temp/09/" --outDir "../drive/MyDrive/Output/svg" --refSVG "./Src/Ref-svg.svg"

echo "11 - svg2png"
inputdir='../drive/MyDrive/Output/svg/'
outputdir='../drive/MyDrive/Output/png/'
if [ ! -e $"$outputdir" ]
then
   mkdir $"$outputdir"
fi
for g in $inputdir*
do
    FILE=$(basename "${g}")
    FILE1="${FILE%%.*}"
    #echo $outputdir$FILE1
    convert $g -colorspace Gray $outputdir$FILE1".png"
    # convert $g -colorspace Gray -resize 1024x1024 $outputdir$FILE1".png"
done

rm -rf "../drive/MyDrive/Src/temp"
