#!/bin/bash

# Get config
source /home/tjacumin/Documents/test-immich.conf

# Get album id
ALBUM_ID=$(curl --location 'https://photos.matheor.com/api/albums' --header "x-api-key: $API_KEY" | jq -r --arg name "$ALBUM_NAME" '.[] | select(.albumName == $name) | .id')

# Get images
ASSETS=($(curl --location "https://photos.matheor.com/api/albums/$ALBUM_ID" --header "x-api-key: $API_KEY" | jq -r '.assets[].id'))

IS_LANDSCAPE=0
while [ "$IS_LANDSCAPE" -eq 0 ]; do
	FOUND=0
	while [ "$FOUND" -eq 0 ]; do
		RAND=$(awk -v min=0 -v max="${#ASSETS[@]}" 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
		ASSET_ID=${ASSETS[$RAND]}
		ASSET_TYPE=$(curl --location "https://photos.matheor.com/api/assets/$ASSET_ID" --header "x-api-key: $API_KEY" | jq -r '.originalMimeType')

		# Detect image mimetype
		if [ $ASSET_TYPE = "image/jpeg" ]
		then
			ASSET_EXTENSION="jpg"
			FOUND=1
		elif [ $ASSET_TYPE = "image/png" ]
		then
			ASSET_EXTENSION="png"
			FOUND=1
		else
			echo "Inconnue"
		fi
	done

	# Download image
	curl --location "https://photos.matheor.com/api/assets/$ASSET_ID/original" --header "x-api-key: $API_KEY" --output "/home/tjacumin/Pictures/.wallpaper.download.$ASSET_EXTENSION"

	# Get width and height using ImageMagick
	read width height < <(identify -format "%w %h" "/home/tjacumin/Pictures/.wallpaper.download.$ASSET_EXTENSION")

	if (( width > height )); then
	  echo "landscape"
	  IS_LANDSCAPE=1
	elif (( width < height )); then
	  echo "portrait"
	else
	  echo "square"
	fi
done

mv "/home/tjacumin/Pictures/.wallpaper.download.$ASSET_EXTENSION" "/home/tjacumin/Pictures/.wallpaper.$ASSET_EXTENSION"

# Set background
dconf write /org/gnome/desktop/background/picture-uri "'file:///home/tjacumin/Pictures/.wallpaper.$ASSET_EXTENSION'" 
dconf write /org/gnome/desktop/background/picture-uri-dark "'file:///home/tjacumin/Pictures/.wallpaper.$ASSET_EXTENSION'"
dconf write /org/gnome/desktop/background/picture-options "'zoom'"
dconf write /org/gnome/desktop/background/primary-color "'#000000'"