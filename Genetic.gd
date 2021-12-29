extends Node

# genetic algorithm framework
# ---



var generations = []
var genfitness = []
var gensize = 20 # size per generation


func randomgen():# generates a completely random first generation
	var outgen = []
	var randomizer = RandomNumberGenerator.new() # to create new seed
	
	for i in range(gensize):
		var gene = [[],[],[],[],[]] # for one organism
		for j in range(8):
			gene[0].append(randomizer.randf_range(-1,1)) # x coord
			gene[1].append(randomizer.randf_range(-1,1)) # y coord
			gene[2].append(round(randf())) # wheelenabled
			gene[3].append(randf()) # wheel radius (close to 0 means no wheel)
			gene[4].append(randf()*2) # wheel weight (0-2x weight) (close to 0 means no weight)
		outgen.append(gene)
	
	return outgen

# selects 2 from set
func roulette_selection(set):
	var selection = []
	var fitset = genfitness[-1] # fitness of the last generation
	var wheel = 0
	for i in fitset:
		wheel += i
	
	for i in range(2):
		var pick = rand_range(0,wheel)
		var current = 0
		for j in fitset:
			current += j
			if current > pick:
				selection.append(set[j])
	return selection

func rand_selection(set, size=2):
	var selection = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(size):
		selection.append(set[rng.randi_range(0,gensize-1)])
	return selection

func single_point_crossover(chrom1, chrom2):
	var rng = RandomNumberGenerator.new()
	var crosspoint = rng.randi_range(1,7)
	for i in range(len(chrom1)): 
		# chromosome 1
		var keep = chrom1[i].slice(0,crosspoint-1)
		var add = chrom2[i].slice(crosspoint,7)
		# chromosome 2
		var keep2 = chrom2[i].slice(0,crosspoint-1)
		var add2 = chrom1[i].slice(crosspoint,7)
		
		# crossover
		chrom1[i] = keep + add
		chrom2[i] = keep2 + add2
	return [chrom1,chrom2]
		

# selects 2 from set
func elitism_selection(set : Array):
	var selection = []
	
	for i in range(len(set)):
		set[i].append(genfitness[-1][i])
	
	set.sort_custom(self, "fitcomp")
	for i in range(2):
		selection.append(set[i])
		
	# removes temporary fitness addon
	for i in set:
		for j in i:
			if typeof(j) != TYPE_ARRAY:
				i.erase(j)
	return selection

# custom comparitor for sorting by fitness
func fitcomp(a,b):
	return a[-1] > b[-1]


# selects 2 from set, tsize = tournament size
func tournament_selection(set, tsize):
	var selection = []
	for i in range(len(set)):
		set[i].append(genfitness[-1][i])
	
	set.sort_custom(self, "fitcomp")
	for i in range(2):
		var tournament = []
		for j in range(tsize):
			tournament.append(set[rand_range(0,gensize-1)])
		
		tournament.sort_custom(self,"fitcomp")
		selection.append(tournament[0])
	
	# removes temporary fitness addon
	for i in set:
		for j in i:
			if typeof(j) != TYPE_ARRAY:
				i.erase(j)
	return selection


func nextgen(prevgen):
	var gen = []
	
	# elitism pick
	var best2 = elitism_selection(prevgen)
	gen.append_array(best2)
	while len(gen) < gensize:
		var selection = tournament_selection(prevgen,5)
		var crossover = single_point_crossover(selection[0],selection[1])
		var newchildA = crossover[0]
		var newchildB = crossover[1]
		
		# will do mutation later
		# MUTATION CODE
		# MUTATION CODE
		# MUTATION CODE
		
		gen.append(newchildA)
		gen.append(newchildB)
	
	# set the next generation
	generations.append(gen)


# distance: the total distance travelled from start
# wheelsum: sum of sizes of all wheels (we want to minimize)
func fitness(distance, wheelsum, lifetime):
	return pow(distance,3)-pow(wheelsum*10,2)-pow(lifetime*90,3) # all factors
	#return pow(distance,3)-pow(lifetime*90,3) # we dont care about wheels
	#return pow(wheelsum,2) # we like wheels
	#return -lifetime # we only care about speed
	

func _enter_tree():
	generations.append(randomgen())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
