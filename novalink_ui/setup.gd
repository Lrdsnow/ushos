extends Control

signal any_button

var wifi=false

# Called when the node enters the scene tree for the first time.
func _ready():
	ushos()
	$first.show()
	$AnimationPlayer.play("open")
	await any_button
	$first.queue_free()
	if wifi:
		$wifi.show()
		await any_button
		$wifi.queue_free()
	$acc_stp.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventScreenTouch or event is InputEventJoypadButton:
		if event.pressed:
			any_button.emit()


func _on_button_pressed():
	if not %acc/usr/LineEdit.text == "" and %acc/pwd/LineEdit.text == %acc/HBoxContainer3/LineEdit.text and not %acc/pwd/LineEdit.text == "":
		Global.username = %acc/usr/LineEdit.text
		if not Global.debug:
			OS.execute("useradd", ["-m", Global.username])
			OS.execute("chpasswd", ["<<", Global.username+":"+%acc_stp/acc/pwd/LineEdit.text])
		$acc_stp.queue_free()
		$end.show()
		var timer = Timer.new()
		timer.set_wait_time(3)
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()
		await timer.timeout
		timer.queue_free()
		Global.save_config_files()
		if Global.debug:
			get_tree().change_scene_to_file("res://main.tscn")
		else:
			OS.execute("reboot", [])

func ushos():
	$first/Label.text = "UshOS"
	$first/Label2.text = "Welcome To UshOS\n\nPress Anything To Get Started"
	$acc_stp/acc/usr/LineEdit.placeholder_text = "ushos"
	$end/Label2.text = "Setup Finished\n\nYour system will now reboot"
