extends Node

# genetic algorithm framework
# ---



var generations = []
var gensize = 10 # size per generation


func randomgen():# generates a completely random first generation
	var outgen = []
	var randomizer = RandomNumberGenerator.new() # to create new seed
	
	for i in range(gensize):
		var gene = [[],[],[],[],[]] # for one organism
		for j in range(8):
			gene[0].append(randomizer.randf_range(-1,1)) # x coord
			gene[1].append(randomizer.randf_range(-1,1)) # y coord
			gene[2].append(randf()) # weight
			gene[3].append(randf()) # wheel radius (close to 0 means no wheel)
			gene[4].append(randf()) # wheel weight (close to 0 means no wheel)
		outgen.append(gene)
	
	return outgen

func _enter_tree():
	generations.append(randomgen())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
