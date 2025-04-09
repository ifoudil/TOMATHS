extends LineEdit

var nombreChange = false
var actions_texte = {
	"puissance" : "^",
	"a": "a",
	"division": "/",
	"inconnue 1 (x)": "x",
	"moins": "-",
	"plus": "+",
	"parentheseGauche" : "(",
	"parentheseDroite" : ")",
	"cos" : "cos(x)",
	"sin" : "sin(x)",
	"exp":"e^x"
}
func _physics_process(delta):


	for action in actions_texte.keys():
		if Input.is_action_just_pressed(action):
			if nombreChange : 
				text+= %PrevueNombre.text
				nombreChange=false
			text += actions_texte[action]

	if Input.is_action_just_pressed("delete"):
		resetText()
		
	if Input.is_action_just_pressed("confirmer (manette)"):
		text+= %PrevueNombre.text
		nombreChange=false
		
	for i in range(10):
		if Input.is_action_just_pressed(str(i)):
			text += str(i)


	if Input.is_action_just_pressed("plusNombre (manette)"):
		var nombre = int(%PrevueNombre.text) #meme s'il n'y a rien le cast en int va interpreter comme 0
		if nombre <9 : 
			nombre +=1
		%PrevueNombre.text = str(nombre)
		nombreChange = true
	if Input.is_action_just_pressed("moinsNombre (manette)"):
		var nombre = int(%PrevueNombre.text) #meme s'il n'y a rien le cast en int va interpreter comme 0
		if nombre > 0 : 
			nombre -=1
		%PrevueNombre.text = str(nombre)
		nombreChange = true
	

func getText():
	return text

func resetText():
	text=""
