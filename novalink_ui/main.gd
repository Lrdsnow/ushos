extends Control

var focusedButton: Button = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("start")
	for app in %apps.get_children():
		if app is Button:
			app.focus_entered.connect(_on_app_hover.bind(app, true, app.custom_minimum_size))
			app.focus_exited.connect(_on_app_hover.bind(app, false, app.custom_minimum_size))
			app.size_flags_vertical = 8
	focusedButton = %apps.get_children()[0]
	focusedButton.grab_focus()
	%apps.get_parent().set_deferred("scroll_horizontal", 0)
	%mainacc.text = Global.username


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		focusedButton.pressed.emit()

func _on_app_hover(app, hover, min_size):
	if hover:
		app.custom_minimum_size = Vector2(min_size.x*1.3,min_size.y*1.3)
	else:
		app.custom_minimum_size = Vector2(min_size.x,min_size.y)
