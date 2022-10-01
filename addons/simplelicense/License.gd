extends Resource

## Stores Copyright, and License information [br]
##
##
## [color=red][b]IMPORTANT:[/b][/color] Any file that Godot cannot load, that is put into the variables[br] [member files][br]or[br][member directories][br] will prevent Godot from being able to compile[br][br]
## [br]
## Static functions allow for exporting all licenses to [br]
## user://licenses/<license_name>.txt [br]
## and a machine readable file, [br]
## user://combined_licenses.txt [br]
## that combines both the license text, [br]
## with the copyright info of all the licenses inside of [br]
## res://licenses/license_scripts/<License Resource Files> [br]
## as well as the Godot Engine and it's third party licenses [br]
## [br]
## Useful Links when it comes to understanding and complying to licensing [br]
## [url=https://docs.godotengine.org/en/stable/about/complying_with_licenses.html]Godot's docs - complying with licenses[/url][br]
## [url=https://creativecommons.org/licenses/]Creative Commons Website[/url][br]
## [br]
## Understanding the format of [br]
## user://combined_licenses.txt [br]
## [url=https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/]debian copyright format 1.0 - (A standard for creating human and machine readable "all-in-one" license files)[/url][br]
## [url=https://spdx.org/licenses/]SPDX License List / SPDX Specification - (A standard for formatting "short" License names)[/url][br]
## [br]
## [color=green] Best way to use this license managment plugin [/color], is through the Godot Editor itself [br]
## Create all your [License] files inside of res://licenses/license_scripts/ [br]
## Place all of your License [b]TEXT[/b] files inside of res://licenses/ [br]
## Edit the Resource files directly through the Godot Editor[br]
## then just execute the static function[br]
## [method License.export_licenses] [br]
## It will return a formatted string (debian copyright-format), with all of the copyright info and license text[br]
## from any [License] file in the directory res://licenses/license_scripts/ AND Godot's licensing information[br]
## if you want to export these licenses to files, then just see the docs on [method License.export_licenses][br][br]
## if you want to create/modify the License or Copyright Resources from code[br]
##
##
## Here's an Example:
##    [codeblock]
##    var license = License.new()
##    var copyright = Copyright.new()
##    #
##    copyright.creators = "John Doe, Corp Entity"
##    copyright.years = "2002, 2005-2006"
##    license.copyrights.append(copyright)
##    #
##    license.title = "CC0-1.0\nCC0 1.0 Universal"
##    license.raw_paths.append("res://script_i_made.gdscript")
##    # license.files.append(load("res://image_i_made.svg"))
##    # license.directories.append(load("res://directory_of_my_stuff/any_resource_file.tres"))
##    license.license_type = 'CC0-1.0'
##    license.license_text_file = License.LICENSES_DIRECTORY.path_join("CC0-1.0.txt")
##    # or
##    # license.license_text_file = "res://licenses/CC0-1.0.txt"
##    #
##    print(license)
##    #
##    # ResourceSaver.save(license, License.LICENSE_SCRIPTS_DIRECTORY)
##    # print(License.export_licenses())
##    [/codeblock]
class_name License

enum FEATURE_SHARING {
	MISSING,  ## Value Missing / Ignore
	YES,  ## Others can share adaptations of this work under any terms.
	SHARE_ALIKE,  ## Others must use the same license if they adapt this work.
}

enum FEATURE_USAGE {
	MISSING,
	COMMERCIAL,  ## Others can use this work for commercial purposes.
	EDUCATIONAL,  ## Others can [b]ONLY[/b] use this work for educational purposes.
	PERSONAL,  ## Others can [b]ONLY[/b] use this work for personal purposes.
}

enum FEATURE_ATTRIBUTION {
	MISSING,
	ATTRIBUTION_REQUIRED,  ## Anyone using this work must include proper attribution.
	ATTRIBUTION_NOT_REQUIRED,  ## Anyone can use this work, even without giving the author attribution.
}

enum FEATURE_DERIVATIVE_WORKS {
	MISSING,
	CAN_BE_MODIFIED,  ## Others can remix, adapt, or build upon this work.
	CANNOT_BE_MODIFIED,  ## Others may only use this work in unadapted form.
}

enum FEATURE_ROYALTIES {
	MISSING,
	ROYALTY_FREE,  ## May be used without the need to pay royalties or license fees for each use, per each copy or volume sold or some time period of use or sales.
	ROYALTY,
}

## The directory to put all of your license [b]TEXT[/b] files
const LICENSES_DIRECTORY: String = "res://licenses/"
## The directory to put all of your license [b]License Resource[/b] files
const LICENSE_SCRIPTS_DIRECTORY: String = "res://licenses/license_scripts/"

## The files that are under this license[br][br]
## [color=red][b]IMPORTANT:[/b][/color] Any file that Godot cannot load, that is put into the variables[br] [member files][br]or[br][member directories][br] will prevent Godot from being able to compile
@export var files: Array[Resource]
## Directories that are under this license[br][br]
## [color=red][b]IMPORTANT:[/b][/color] Any file that Godot cannot load, that is put into the variables[br] [member files][br]or[br][member directories][br] will prevent Godot from being able to compile
@export var directories: Array[Resource]
## Same as above, just as a workaround for any files that Godot doesn't know how to load() aka .txt .cfg etc[br]
@export var raw_paths: Array[String]

@export_group("Basics - Required")
## License Title / Name
@export_placeholder("Component Name")
var title: String = ""
## Array of [Copyright]s
@export var copyrights: Array[Copyright] = []
## The "short" License Name - Refer to the SPDX Specifications[br]
## [url=https://spdx.org/licenses/]SPDX License List / SPDX Specification - (A standard for formatting "short" License names)[/url]
@export_placeholder("CC0 | MIT etc") var license_type: String = ""
## The file containing the license text[br]
## like so [br]
## [url=https://github.com/godotengine/godot/blob/master/LICENSE.txt]Godot's License file[/url]
@export_file("*.txt,*.license") var license_text_file: String = ""

@export_subgroup("Optional")
## Anything extra that you want to add to license text [br]
## it will be put in the "comment" section, after everything else
@export_multiline
var extra: String = ""

@export_group("Features", "feature")
## Whether you are required to attribute/credit the author, of works under this license
@export
var feature_attribution: FEATURE_ATTRIBUTION = 0
## How you can use works under this license
@export var feature_usage: FEATURE_USAGE = 0
## Whether you can create alterations of works under this license, and share those altered version
@export var feature_derivative_works: FEATURE_DERIVATIVE_WORKS = 0
## Whether you have to keep the same license for derivative (altered) works, that are under this license
@export var feature_sharing: FEATURE_SHARING = 0
## Whether you have to pay royalties for works under this license
@export var feature_royalties: FEATURE_ROYALTIES = 0

@export_group("Notes")
## Notes for your use[br]
## This will not be included, when the License is exported in any way
@export_multiline
var notes: String = ""


## Returns a formatted string based on the debian copyright format
func _to_string() -> String:
	return self.to_formatted_string("debian-copyright-format")


## Returns the text from the file pointed to from [license_text_file] [br]
## if the file doesn't exist, it returns an empty string
func get_license_file_text() -> String:
	if license_text_file == null or not FileAccess.file_exists(license_text_file):
		# See if the Godot Engine contains the right license Text File
		# And use that as a substitute for the missing license text file
		var tmp = Engine.get_license_info().get(license_type)
		if license_type == "MIT" and tmp == null:
			# they are the same license; Godot doesn't carry a duplicate file
			tmp = Engine.get_license_info().get("Expat")
		return "" if tmp == null else tmp
	else:
		var f = FileAccess.open(self.license_text_file, FileAccess.READ)
		return "" if f == null else f.get_as_text()


## Hard-Coded Formats: [br]
## debian-copyright-format [br]
## engine-component-format [br]
## [br]
## [code]padding[/code] [br]
## just prefixes every newline with that "padding"
## [br]
## Custom Format - Similar to String.format():[br]
## {files}[br]
## {copyrights}[br]
## {license_type}[br]
## {license_file_text}[br]
## {extra}[br]
## {comment} = title + extra[br]
## [br]
## Example:[br]
## [code]to_formatted_string("Title: {title}\n Short License Name: {license_type}") [/code]
func to_formatted_string(format: String = "debian-copyright-format", padding: String = " "):
	var dcf = format == "debian-copyright-format"
	var ect = format == "engine-component-format"
	if dcf:
		padding = " "
		format = "Files:{files}\nComment:{comment}\nCopyright:{copyrights}\nLicense:{license_type}"
	elif ect:
		padding = " "
		format = "Files:\nComment:{comment}\nCopyright:{copyrights}\nLicense:{license_type}"

	var _files = ""
	if format.find("{files}") != -1:
		for x in files:
			_files += x.resource_path.replace("res://", " ./").strip_edges() + "\n"
		for x in directories:
			_files += (
				x.resource_path.replace("res://", " ./").rsplit("/", false, 1)[0].strip_edges()
				+ "/\n"
			)
		for x in raw_paths:
			_files += x.replace("res://", " ./").strip_edges() + "\n"
	_files = _files.strip_edges()

	var _comment = ""
	if not title.is_empty():
		_comment += title
		if not extra.is_empty():
			_comment += "\n"
	if not extra.is_empty():
		_comment += extra

	return format.format(
		{
			# files
			"files": _add_line_padding(_files, padding),
			# basics
			"title": _add_line_padding(title, padding),
			"copyrights": _add_line_padding("\n".join(copyrights), padding),
			"license_type": _add_line_padding(license_type, padding),
			"license_file_text":
			"" if format.find("{license_file_text}") == -1 else get_license_file_text(),
			# optional
			"extra": _add_line_padding(extra, padding),
			"comment": _add_line_padding(_comment, padding),
		}
	)


## Used for creating license String, Files in the debian copyright-format.[br]
## [br]
## [code]export_combined_license_file[/code][br]
## Creates a single file containing all copyright and license text in the [br]
## debian copyright-format 1.0 [br]
## File Path: [br]
## user://combined_license.txt [br]
## [code]export_individual_license_files[/code][br]
## Exports all INDIVIDUAL license TEXT files into[br]
## user://licenses/...  [br]
## [br]
## Formatting Reference [br]
## [url=https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/]debian copyright format 1.0 - (A standard for creating human and machine readable "all-in-one" license files)[/url][br]
static func export_licenses(
	export_combined_license_file: bool = false, export_individual_license_files: bool = false
) -> String:
	var combined_txt: String = ""
	var combined_file: String = "user://combined_licenses.txt"
	var exec_dir: String = OS.get_executable_path().rsplit("/", false, 1)[0] + "/licenses"
	var out_dir: String = "user://licenses/"
	var cfile: FileAccess
	if export_combined_license_file:
		cfile = FileAccess.open(combined_file, FileAccess.WRITE)
	if export_individual_license_files or export_combined_license_file:
		if cfile == null:
			print(
				(
					"License.export_licenses: FAILED (%s) to open 'combined_file' file %s"
					% [FileAccess.get_open_error(), combined_file]
				)
			)
			return "ERROR"

	if export_individual_license_files or export_combined_license_file:
		if not DirAccess.dir_exists_absolute(out_dir):
			var err = DirAccess.make_dir_absolute(out_dir)
			if err != OK:
				print("License.export_licenses: FAILED (%s) to create %s" % [err, out_dir])
				return "ERROR"

	var odir = DirAccess.open(out_dir)

	var ldir = DirAccess.open(LICENSES_DIRECTORY)
	var sdir = DirAccess.open(LICENSE_SCRIPTS_DIRECTORY)

	var success = true

	combined_txt += "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/\n"
	combined_txt += "\n"  # end of header
	combined_txt += "# Game Copyright Info \n\n"

	# Generate Combined License File
	var license_scripts := []
	for name in sdir.get_files():
		name = name.replace(".remap", "")
		var license_script = load(LICENSE_SCRIPTS_DIRECTORY.path_join(name))
		if license_script == null:
			print(
				"License.export_licenses: FAILED to load license script file\n",
				LICENSE_SCRIPTS_DIRECTORY.path_join(name),
				"\n"
			)
			success = false
		elif license_script is Resource and license_script.has_method("export_licenses"):
			license_scripts.append(license_script)
			combined_txt += str(license_script) + "\n\n"

	combined_txt += "# Godot Engine and Engine Component Copyright Info \n\n"

	# Export godot copyright info
	var godot_copyright = get_godot_copyright_info()
	for c in godot_copyright.by_title.values():
		combined_txt += c.to_formatted_string("engine-component-format") + "\n\n"

	combined_txt += "\n\n"  # empty lines between, copyright info and license text

	var duck := {}  # which license text files have already been printed/exported

	# Copy ALL License Text files
	for ls in license_scripts:
		if duck.get(ls.license_type, false):
			continue
		var a = ls.get_license_file_text()
		if a.is_empty():
			continue
		else:
			duck[ls.license_type] = true
			var yet_another_var = _add_line_padding(a.strip_edges(false), " ")
			combined_txt += "License: " + ls.license_type + "\n"
			combined_txt += yet_another_var
			combined_txt += "\n\n"
			if export_individual_license_files:
				if not FileAccess.file_exists(out_dir.path_join(ls.license_type) + ".txt"):
					var tmp = FileAccess.open(
						out_dir.path_join(ls.license_type) + ".txt", FileAccess.WRITE
					)
					if tmp is FileAccess:
						tmp.store_string(yet_another_var)
					else:
						print(
							(
								"License.export_licenses: FAILED to write to "
								+ out_dir.path_join(ls.license_type)
								+ ".txt"
							)
						)

	# Copy Godot License Files
	var gli = Engine.get_license_info()
	var keys = gli.keys()
	var values = gli.values()
	for i in range(keys.size()):
		if duck.get(keys[i], false):
			continue

		var path = out_dir.path_join(keys[i] + ".txt")
		if FileAccess.file_exists(exec_dir.path_join(keys[i])):
			continue

		combined_txt += "License: " + keys[i] + "\n"
		combined_txt += _add_line_padding(values[i].strip_edges(false), " ")
		combined_txt += "\n\n"
		duck[keys[i]] = true

		if export_individual_license_files:
			var f = FileAccess.open(path, FileAccess.WRITE)
			if f is FileAccess:
				if export_individual_license_files:
					f.store_string(values[i])
			else:
				print(
					(
						"License.export_licenses: FAILED to write godot component license to text file\n%s"
						% [path]
					)
				)
				success = false

	if export_combined_license_file:
		cfile.store_string(combined_txt)

	return combined_txt


static func _add_line_padding(lines: String, padding: String) -> String:
	if lines.is_empty():
		return lines
	var s = ""
	for x in lines.split("\n"):
		if x.is_empty() or x == "\n":
			s += padding + "." + "\n"
		else:
			s += padding + x + "\n"
	s = s.strip_edges(false)
	return s


## Get the copyright information of the Godot engine [br]
## Returns a [Dictionary] where [br]
## {"by_title": by_title (Dictionary), "by_type": by_type (Dictionary)}
## Key: [member License.title][br]
## Value: [Copyright][br]
## [br]
## [code]match_title[/code][br]
## ONLY return the copyrights whos name's match one of these strings [br]
## else, leave empty to return ALL of Godot's copyright info
static func get_godot_copyright_info(match_title: PackedStringArray = PackedStringArray()) -> Dictionary:
	var by_title = {}
	var by_type = {}
	for a in Engine.get_copyright_info():
		if not match_title.is_empty() and match_title.find(a.title) == -1:
			continue
		var b = new()
		b.title = a.name
		b.raw_paths = a.parts[0].files
		b.license_type = a.parts[0].license
		for cs in a.parts[0].copyright:
			var c = Copyright.new()
			var t = cs.split(", ", false, 1)
			c.years = t[0]
			if len(t) > 1:
				c.creators = t[1]
			b.copyrights.append(c)
		by_type[b.license_type] = b
		by_title[b.title] = b
	return {"by_title": by_title, "by_type": by_type}


## Get the copyright information for the Game, not to be confused with [method get_godot_copyright_info] [br]
## Returns a [Dictionary] where [br]
## {"by_title": by_title (Dictionary), "by_type": by_type (Dictionary)}
## Key: [member License.title][br]
## Value: [Copyright][br]
## [br]
## [code]match_title[/code][br]
## ONLY return the copyrights whos name's match one of these strings [br]
## else, leave empty to return ALL (Game related) copyright info
static func get_game_copyright_info(match_title: PackedStringArray = PackedStringArray()) -> Dictionary:
	var sdir = DirAccess.open(LICENSE_SCRIPTS_DIRECTORY)
	var by_title = {}
	var by_type = {}
	for name in sdir.get_files():
		name = name.replace(".remap", "")
		var license_script = load(LICENSE_SCRIPTS_DIRECTORY.path_join(name))
		if license_script is Resource and license_script.has_method("export_licenses"):
			if not match_title.is_empty() and match_title.find(license_script.title) == -1:
				continue
			by_title[license_script.title] = license_script
			by_type[license_script.license_type] = license_script
	return {"by_title": by_title, "by_type": by_type}
