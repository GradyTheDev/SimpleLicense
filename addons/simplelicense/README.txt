A simple plugin, to make dealing with licensing simple.
Files: ./addons/simplelicense/*
License: CC0-1.0

Developed in Godot version: v4.0.beta.custom_build [166df0896]

Quick Example:
	Run the Scene at
	res://addons/simplelicense/LicenseGUI.tscn
	
	look around, then
	click on the "open data directory" button
	then click on the "save licenses" button
	and watch the data directory populate with license files


Quick Start:
	1. Create a License (Custom Resource) file inside the 
		res://licenses/license_scripts/
	2. Click on the the new Resource file, and try it out
		There are docs on how to use it, so just F1 + License, to find out more
	3. Export you license
		in your game/app just
		print(License.export_licenses())
		and boom, you'll see your newly minted license, and all of godot's licenses as well
		There is more you can do, just visit the docs!
