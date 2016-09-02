#!/bin/sh

# cd $1

find /Volumes/Data/iOS/ChristmasFacePaint/App/Resources/Images/activities/facepaint/themes/frozen | while read file
# for file in find /Volumes/Data/iOS/ChristmasFacePaint/App/Resources/Images/activities/facepaint/themes/christmas
do
	echo $file
	mv "$file" "${file/-princess-/-frozen-}";
done

