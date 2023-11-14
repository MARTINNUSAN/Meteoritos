#SectorMeteoritos
class_name SectorMeteoritos
extends Node2D

##Atributos 
var cantidad_meteoritos:int = 10
var intervalo_spawn:float = 1.2
var spawners:Array

## Constructor
func crear(pos: Vector2, meteoritos:int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos


##Metodos
func _ready() -> void:
	almacenar_spawners()
	conectar_seniales_detectores()
	$SpawnTimer.wait_time = intervalo_spawn
	
##Metodos Custom
func conectar_seniales_detectores() -> void:
	for detector in $DetectorFueraDeZona.get_children():
		detector.connect("body_entered", self, "_on_DetectorIzquierdo_body_entered")
		detector.connect("body_entered", self, "_on_DetectorDerecho_body_entered")
		detector.connect("body_entered", self, "_on_DetectorSuperior_body_entered")
		detector.connect("body_entered", self, "_on_DetectorInferior_body_entered")

func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()

##Señales Internas

func _on_SpawnTimer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		return
		
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -= 1



func _on_DetectorIzquierdo_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
	
func _on_DetectorDerecho_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
	
func _on_DetectorSuperior_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
	
func _on_DetectorInferior_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
