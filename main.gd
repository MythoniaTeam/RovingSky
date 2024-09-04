extends Node2D
var v:Vector2

var joy_num := 0
var cur_joy := -1
var checking_num = 0
@onready var joypad_name: RichTextLabel = $DeviceInfo/JoyName
@onready var joypad_number: SpinBox = $DeviceInfo/JoyNumber

func _ready():
	var player:PackedScene = load("res://player.tscn")
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	if len(Input.get_connected_joypads()) > 0:
		for joypad in Input.get_connected_joypads():
			print_rich("Found joypad #%d: [b]%s[/b] - %s" % [joypad, Input.get_joy_name(joypad), Input.get_joy_guid(joypad)])
			var new_player = player.instantiate()
			new_player.position = $Ship.global_position
			new_player.master = joypad
			add_child(new_player)
	else:
		var new_player = player.instantiate()
		new_player.position = $Ship.global_position
		new_player.joy = false
		add_child(new_player)

func _process(delta):
	pass
	
func set_joypad_name(joy_name: String, joy_guid: String) -> void:
	# Make the GUID clickable (and point to Godot's game controller database for easier lookup).
	joypad_name.set_text("%s\n[color=#fff9][url=https://github.com/godotengine/godot/blob/master/core/input/gamecontrollerdb.txt]%s[/url][/color]" % [joy_name, joy_guid])
	# Make the rest of the UI appear as enabled.
	for node: CanvasItem in [$JoypadDiagram, $Axes, $Buttons, $Vibration, $VBoxContainer]:
		node.modulate.a = 1.0
	
func _on_joy_connection_changed(device_id: int, connected: bool) -> void:
	if connected:
		print_rich("[color=green][b]+[/b] Found newly connected joypad #%d: [b]%s[/b] - %s[/color]" % [device_id, Input.get_joy_name(device_id), Input.get_joy_guid(device_id)])
	else:
		print_rich("[color=red][b]-[/b] Disconnected joypad #%d.[/color]" % device_id)

	if device_id == cur_joy:
		# Update current joypad label.
		if connected:
			set_joypad_name(Input.get_joy_name(device_id), Input.get_joy_guid(device_id))
		else:
			joypad_name.set_text("[i]No controller detected at ID %d.[/i]" % joypad_number.value)
			# Make the rest of the UI appear as disabled.
			for node: CanvasItem in [$JoypadDiagram, $Axes, $Buttons, $Vibration, $VBoxContainer]:
				node.modulate.a = 0.5
