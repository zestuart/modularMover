#!/bin/bash 

year=$(date +%Y)
today=$(date -I date)
vol="2TB"

topLevel="/Volumes/$vol/$year"
fullPath="$topLevel/$today"
source="/Volumes/Untitled/DCIM/100MEDIA/"

fileTypes=$(ls $source | awk -F'[.]' '{print $2}' | sort | uniq)

if [ -d $source ]; then
	echo "Source directory present."
	if [ -d /Volumes/$vol ]; then
		if [ -d "$topLevel" ]; then
		    echo "$topLevel present."
		else
			mkdir $topLevel
		fi

		if [ -d "$fullPath" ]; then
		    echo "$fullPath present."
		else
			mkdir $fullPath	
		fi
	else
		echo "Unable to find destination volume: did you plug it in?"
		exit 1
	fi
else
	echo "Unable to find source media to copy: did you plug it in?"
	exit 1
fi

for i in $fileTypes
do
	fileCount=$(ls $source/*.$i | grep -c $i)
	if [ $i == SRT ] ;then 
		echo "Skipping SRT $fileCount file(s)..."
	else
		if [ $i == DNG ]; then
			if [ -d $fullPath/$i ]; then
	   			mv "$source"*.$i $fullPath/$i
	   		else
		   		mkdir $fullPath/$i
		   		mv "$source"*.$i $fullPath/$i
	   		fi
		else
			if [ $i == MP4 ]; then
				mv "$source"*.$i $fullPath/
			fi
		fi
	fi
done

