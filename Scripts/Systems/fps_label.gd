extends Label

# Variáveis para cálculo do FPS
var frame_count := 0
var time_accumulated := 0.0

# Função chamada a cada frame
func _process(delta):
	frame_count += 1
	time_accumulated += delta

	# Atualiza o FPS a cada segundo
	if time_accumulated >= 1.0:
		var fps = frame_count / time_accumulated
		text = "FPS: " + str(round(fps))
		frame_count = 0
		time_accumulated = 0.0
