# Defined in /var/folders/jn/f193c5511c1_jpz0xck_7rtr0000z8/T//fish.UO8H1f/makeicon.fish @ line 2
function makeicon
	if ! test -f "$argv"
		echo "File $argv does not exist."
		return
	end
	set EXT (echo $argv | awk -F '.' '{ print $NF }')
	set NAME (echo $argv | awk -F .$EXT '{ print $1 }')
	if test -f "$NAME.icns"
		echo "$NAME.icns already exists."
		echo "Did nothing."
		return
	end
	if test $EXT = "PNG"
		echo "File is a $EXT"
		echo "Good, good. Continuing."
	else if test $EXT = "png"
		echo "File is a $EXT"
		echo "Good, good. Continuing."
	else
		echo "File is a $EXT"
		echo "Converting..."
		if test -f "$NAME.png"
			echo "$NAME.png already exists."
			echo "Did nothing."
			return
		else 
			sips --setProperty format png --setProperty formatOptions best "$argv" --out "$NAME.png"
		end
	end
	mkdir $NAME.iconset
	sips -z 16 16 $NAME.$EXT --out $NAME.iconset/icon_16x16.png
	sips -z 16 16 $NAME.$EXT --out $NAME.iconset/icon_16x16@2x.png
	sips -z 32 32 $NAME.$EXT --out $NAME.iconset/icon_32x32.png
	sips -z 32 32 $NAME.$EXT --out $NAME.iconset/icon_32x32@2x.png
	sips -z 64 64 $NAME.$EXT --out $NAME.iconset/icon_64x64.png
	sips -z 64 64 $NAME.$EXT --out $NAME.iconset/icon_64x64@2x.png
	sips -z 128 128 $NAME.$EXT --out $NAME.iconset/icon_128x128.png
	sips -z 128 128 $NAME.$EXT --out $NAME.iconset/icon_128x128@2x.png
	sips -z 256 256 $NAME.$EXT --out $NAME.iconset/icon_256x256.png
	sips -z 256 256 $NAME.$EXT --out $NAME.iconset/icon_256x256@2x.png
	sips -z 512 512 $NAME.$EXT --out $NAME.iconset/icon_512x512.png
	sips -z 512 512 $NAME.$EXT --out $NAME.iconset/icon_512x512@2x.png
	sips -z 1024 1024 $NAME.$EXT --out $NAME.iconset/icon_1024x1024.png
	sips -z 1024 1024 $NAME.$EXT --out $NAME.iconset/icon_1024x1024@2.png
	iconutil -c icns $NAME.iconset
	rm -rf $NAME.iconset
	echo "Done! Created" $NAME.icns
end
