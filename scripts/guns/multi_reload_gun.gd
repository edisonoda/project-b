extends Gun

class_name MultiReloadGun

func _ready():
	setup()

func _process(delta):
	var mouse = get_global_mouse_position()
	reticle.global_position = mouse
	look_at(mouse)
	
	if reload_timer.running:
		reload_progress.progress += (max_ammo / reload_time) * delta * 100

func setup():
	super()
	reload_timer.timeout.disconnect(on_reload_end)
	
	reload_timer.wait_time = reload_time / max_ammo
	reload_pitch_scale = reload_pitch_scale / max_ammo
	reload_pitch_scale = clamp(reload_pitch_scale, 0.75, 1.25)

func reload():
	reload_audio_player.stream = reload_stream
	reload_audio_player.pitch_scale = reload_pitch_scale
	reload_audio_player.play()
	reload_timer.timeout.connect(check_multi_reload_end)
	reload_timer.restart()

func check_multi_reload_end():
	ammo += 1
	
	if ammo >= max_ammo:
		reload_timer.timeout.disconnect(check_multi_reload_end)
		on_reload_end()
	else:
		reload_progress.progress = 0
		reload_audio_player.play()
		reload_timer.restart()
