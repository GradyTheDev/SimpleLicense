extends Control

@onready var tree: Tree = $Tree
@onready var text: TextEdit = $Text

var game_licenses
var godot_licenses

var license_items = {}

#FIX: Slight issue when there are more than one license_type in license_type


func _ready() -> void:
	game_licenses = License.get_game_copyright_info()
	godot_licenses = License.get_godot_copyright_info()

	var root = tree.create_item()

	var ti_all = tree.create_item(root)
	ti_all.set_text(0, "All Components")
	ti_all.set_meta("license", License.export_licenses(false, false))

	var ti_game_components = tree.create_item(root)
	ti_game_components.set_text(0, "Game Components")
	for x in game_licenses.by_title.keys():
		var item = tree.create_item(ti_game_components)
		item.set_text(0, x)
		item.set_meta("license", game_licenses.by_title[x])

	var ti_godot_components = tree.create_item(root)
	ti_godot_components.set_text(0, "Godot Components")
	for x in godot_licenses.by_title.keys():
		var item = tree.create_item(ti_godot_components)
		item.set_text(0, x)
		item.set_meta(
			"license", godot_licenses.by_title[x]
		)
	
	var ti_licenses = tree.create_item(root)
	ti_licenses.set_text(0, "Licenses")
	var used = {}
	for x in godot_licenses.by_title.keys():
		var license = godot_licenses.by_title[x]
		if not used.has(license.license_type):
			var item = tree.create_item(ti_licenses)
			license_items[license.license_type] = item
			item.set_text(0, license.license_type)
			used[license.license_type] = true
			item.set_meta("license", license.get_license_file_text())
	ti_all.select(0)


func _on_tree_item_selected() -> void:
	if tree.get_selected().has_meta("license"):
		text.text = str(tree.get_selected().get_meta("license"))
	else:
		text.text = ""


func _on_tree_item_activated() -> void:
	var item = tree.get_selected()
	if item.has_meta("license"):
		var a = item.get_meta("license")
		if a is License:
			for x in a.license_type.split(" "):
				var b = license_items.get(x)
				if b is TreeItem:
					b.select(0)
					tree.scroll_to_item(b)
					_on_tree_item_selected()
					break
	else:
		item.collapsed = not item.collapsed


func _on_btn_open_data_dir_pressed() -> void:
	OS.shell_open(OS.get_user_data_dir())


func _on_button_pressed() -> void:
	License.export_licenses(true, true)
