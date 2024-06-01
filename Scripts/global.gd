extends Node

var player_current_attack = false

var found_mother_item = false
var given_mother_item = false

var posicion = Vector2()
var zoom = Vector2()


#var current_scene = String
var transition_scene = false

var player_exit_forest_posx = 0
var player_exit_forest_posy = 0
var player_start_posx = 0
var player_start_posy = 0

var lvlProtagonista = 1
var expProtagonista : int
var experience_threshold = 100

var puedetp = false
var puedetp2 = false
var botonesActivados = false

var hpProtagonista = 100
var maxvida = 100
var defensa = 10
var dañoEnemigo = 20
var ataqueProtagonista = 25
var evasionProtagonista = 0
var suerteProtagonista = 0
var aprendeizajePersonaje = 0
var criticoPersonaje = 0
var regeneracionPersonaje = 0

var dañoBoss = 25

var dañoSuperAttackEnemigo = 30
var inventarioAbiertoJugador : bool

var checkpoint : bool
var lastPositon : Vector2
var lastScene : String
var lastZoom : Vector2

var chatPortalAbierto : bool
var chatMadreAbierto : bool
var chatGuardaAbierto : bool

var questIniciada : bool

var nextZoneCuevaUnlocked : bool

var pausaopen : bool

var pathPause : String
var playerPosition : Vector2

var escenaFinal : bool

