
# Regex
regx_bands 		= r"(.*)?what bands were born in (\d{2}s)(.*)?\?"
regx_recommend  = r"(.*)?can you recommend me (.*)?\?"
regx_tell_me    = r"(.*)?tell me about (.*)?" 
regx_do_you 	= r"(.*)?what (.*)? do you (.*)?\?" 

# Dictionaries 
bands 	= Dict("60s"  => ["the beatles","the rolling stones","the beach boys"],
				"70s" => ["ramones","black sabbath","eagles"],
				"80s" => ["depeche mode","the smiths", "nine inch nails", "blur"],
				"90s" => ["the strokes", "weezer","oasis","the smiths"],
				"2000s" => ["artic monkeys","arcade fire","franz ferdinand","the smiths"])
genres 	= Dict("rock" 	   => ["the rolling stones","arctic monkeys"],
			   "pop"  	   => ["dua lipa","sam smith","lorde"],
			   "metal"	   => ["iron maiden","megadeth","black sabbath"],
			   "hip hop"   => ["kendrick lamar","mac miller","wiz khalifa"],
			   "reggaeton" => ["j balvin","bad bunny","nicky jam"])

# Reponses
resp_spot 	 = "Spotyman: "
resp_hello 	 = "Whay do you wanna know of music?"
resp_bye	 = "Good times!, see you later!"
resp_user_hello = s"\2, What you wanna know of music?"
resp_you 	 = s"I \3 \2 like ... Is this question relevant?"
resp_what 	 = "Some things I don't know"
resp_default = "Go on, ask me!"

# search argument element in values of dictionary argument dic
# return key of the value array where element was found otherwise return ""
function find(dic, element)
	for (key, value) in dic 
			index = findall(b -> cmp(b, element) == 0, value) 
			if !isempty(index)
				return key
			end
		end
	return "" 
end

println("Hello I am Spotyman an expert chatbot of music. What is your name?")
while true 
	s = readline()
	s = lowercase(string(s))
	if occursin(r".*hello.*", s)
		println(resp_spot * response_hello)
	elseif occursin(r"(.*)?my name is (.*)?", s)
		println(resp_spot * replace(s,r"(.*)?my name is(.*)?" => resp_user_hello))
	elseif occursin(regx_bands, s)
		println( resp_spot * join(get(bands, replace(s, regx_bands => s"\2"), 0),", ", " and ") * " were born.")
	elseif occursin(regx_recommend, s)
		r = join(get(genres, replace(s, regx_recommend => s"\2"),""),", ", " and ")
		println( resp_spot * r * " recommend you to hear.")
	elseif occursin(regx_tell_me, s)
		band = replace(s, regx_tell_me=> s"\2")
		time = find(bands, band)
		if cmp(time, "") != 0
			println(resp_spot * band * " were born in " * time)
		else
			println(resp_spot * " I don't know about " * band)
		end
	elseif occursin(regx_do_you , s)
		println(resp_spot * replace(s, regx_do_you => resp_you))
	elseif occursin(r"(.*)?what(.*)?", s)
		println(resp_what)
	elseif occursin(r"(.*)?bye(.*)?", s)
		println(resp_bye)
		break
	else
		println(resp_default)	
	end
end
