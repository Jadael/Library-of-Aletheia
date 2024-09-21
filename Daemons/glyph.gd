# glyph.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## Glyph: The Archon of Symbolic Transmutation
##
## Glyph is the mystical entity responsible for transforming mundane numbers into
## sacred symbols and back again. It serves as the bridge between the realm of
## cold, hard integers and the world of meaningful, esoteric representations.
##
## Responsibilities:
## 1. Convert numbers into various symbolic representations
## 2. Provide a unified interface for all glyph-related operations
## 3. Maintain the sacred array of daemon syllables
## 4. Ensure the integrity and uniqueness of generated glyphs
## 5. Offer insights into the nature of numbers and their symbolic equivalents
##
## Glyph's powers allow other entities in our mystical library to communicate
## in ways that transcend mere numerals, adding layers of meaning and mystique
## to our identifiers and measurements.

## The Glyph Archon's purpose and sacred symbols
const NAME = "✨ Glyph"
@export_multiline var about = """
I am Glyph, the Archon of Symbolic Transmutation. My sacred duty is to bridge
the gap between the mundane world of numbers and the mystical realm of symbols.

Through my arcane arts, I transform cold integers into meaningful glyphs,
allowing our entities to communicate in ways that resonate with the very
fabric of our mystical library. I maintain the sacred array of daemon
syllables, ensuring that each entity can be uniquely identified and
addressed in our grand cosmic dance.

My responsibilities include:
1. Converting numbers into various symbolic representations
2. Providing a unified interface for all glyph-related operations
3. Safeguarding the integrity of our symbolic language
4. Offering insights into the deeper meaning behind our numeric identifiers

Remember, in our realm, a number is never just a number - it's a key to
unlocking deeper truths and connections.
"""

## The syllables used to identify our mystical daemons
const DAEMON_GLYPHS: Array = ["ba","ca","da","fa","ga","ha","ja","ka","la","ma","na","pa","qa","ra","sa","sha","ta","tha","va","wa","xa","ya","za","zha","bae","cae","dae","fae","gae","hae","jae","kae","lae","mae","nae","pae","qae","rae","sae","shae","tae","thae","vae","wae","xae","yae","zae","zhae","bai","cai","dai","fai","gai","hai","jai","kai","lai","mai","nai","pai","qai","rai","sai","shai","tai","thai","vai","wai","xai","yai","zai","zhai","bao","cao","dao","fao","gao","hao","jao","kao","lao","mao","nao","pao","qao","rao","sao","shao","tao","thao","vao","wao","xao","yao","zao","zhao","bau","cau","dau","fau","gau","hau","jau","kau","lau","mau","nau","pau","qau","rau","sau","shau","tau","thau","vau","wau","xau","yau","zau","zhau","bay","cay","day","fay","gay","hay","jay","kay","lay","may","nay","pay","qay","ray","say","shay","tay","thay","vay","way","xay","yay","zay","zhay","be","ce","de","fe","ge","he","je","ke","le","me","ne","pe","qe","re","se","she","te","the","ve","we","xe","ye","ze","zhe","bea","cea","dea","fea","gea","hea","jea","kea","lea","mea","nea","pea","qea","rea","sea","shea","tea","thea","vea","wea","xea","yea","zea","zhea","bee","cee","dee","fee","gee","hee","jee","kee","lee","mee","nee","pee","qee","ree","see","shee","tee","thee","vee","wee","xee","yee","zee","zhee","bei","cei","dei","fei","gei","hei","jei","kei","lei","mei","nei","pei","qei","rei","sei","shei","tei","thei","vei","wei","xei","yei","zei","zhei","beo","ceo","deo","feo","geo","heo","jeo","keo","leo","meo","neo","peo","qeo","reo","seo","sheo","teo","theo","veo","weo","xeo","yeo","zeo","zheo","beu","ceu","deu","feu","geu","heu","jeu","keu","leu","meu","neu","peu","qeu","reu","seu","sheu","teu","theu","veu","weu","xeu","yeu","zeu","zheu","bey","cey","dey","fey","gey","hey","jey","key","ley","mey","ney","pey","qey","rey","sey","shey","tey","they","vey","wey","xey","yey","zey","zhey","bi","ci","di","fi","gi","hi","ji","ki","li","mi","ni","pi","qi","ri","si","shi","ti","thi","vi","wi","xi","yi","zi","zhi","bia","cia","dia","fia","gia","hia","jia","kia","lia","mia","nia","pia","qia","ria","sia","shia","tia","thia","via","wia","xia","yia","zia","zhia","bie","cie","die","fie","gie","hie","jie","kie","lie","mie","nie","pie","qie","rie","sie","shie","tie","thie","vie","wie","xie","yie","zie","zhie","bio","cio","dio","fio","gio","hio","jio","kio","lio","mio","nio","pio","qio","rio","sio","shio","tio","thio","vio","wio","xio","yio","zio","zhio","biu","ciu","diu","fiu","giu","hiu","jiu","kiu","liu","miu","niu","piu","qiu","riu","siu","shiu","tiu","thiu","viu","wiu","xiu","yiu","ziu","zhiu","bo","co","do","fo","go","ho","jo","ko","lo","mo","no","po","qo","ro","so","sho","to","tho","vo","wo","xo","yo","zo","zho","boa","coa","doa","foa","goa","hoa","joa","koa","loa","moa","noa","poa","qoa","roa","soa","shoa","toa","thoa","voa","woa","xoa","yoa","zoa","zhoa","boe","coe","doe","foe","goe","hoe","joe","koe","loe","moe","noe","poe","qoe","roe","soe","shoe","toe","thoe","voe","woe","xoe","yoe","zoe","zhoe","boi","coi","doi","foi","goi","hoi","joi","koi","loi","moi","noi","poi","qoi","roi","soi","shoi","toi","thoi","voi","woi","xoi","yoi","zoi","zhoi","boo","coo","doo","foo","goo","hoo","joo","koo","loo","moo","noo","poo","qoo","roo","soo","shoo","too","thoo","voo","woo","xoo","yoo","zoo","zhoo","bou","cou","dou","fou","gou","hou","jou","kou","lou","mou","nou","pou","qou","rou","sou","shou","tou","thou","vou","wou","xou","you","zou","zhou","boy","coy","doy","foy","goy","hoy","joy","koy","loy","moy","noy","poy","qoy","roy","soy","shoy","toy","thoy","voy","woy","xoy","yoy","zoy","zhoy","bu","cu","du","fu","gu","hu","ju","ku","lu","mu","nu","pu","qu","ru","su","shu","tu","thu","vu","wu","xu","yu","zu","zhu","bua","cua","dua","fua","gua","hua","jua","kua","lua","mua","nua","pua","qua","rua","sua","shua","tua","thua","vua","wua","xua","yua","zua","zhua","bue","cue","due","fue","gue","hue","jue","kue","lue","mue","nue","pue","que","rue","sue","shue","tue","thue","vue","wue","xue","yue","zue","zhue","bui","cui","dui","fui","gui","hui","jui","kui","lui","mui","nui","pui","qui","rui","sui","shui","tui","thui","vui","wui","xui","yui","zui","zhui","buo","cuo","duo","fuo","guo","huo","juo","kuo","luo","muo","nuo","puo","quo","ruo","suo","shuo","tuo","thuo","vuo","wuo","xuo","yuo","zuo","zhuo","bli","cli","dli","gli","hli","pli","qli","rli","sli","tli","vli","wli","xli","yli","zli","bwi","cwi","dwi","fwi","gwi","hwi","jwi","kwi","lwi","mwi","nwi","pwi","qwi","rwi","swi","twi","vwi","wwi","xwi","ywi","zwi","bri","cri","dri","fri","gri","hri","jri","kri","lri","mri","nri","pri","qri","rri","sri","tri","vri","wri","xri","yri","zri","bru","cru","dru","fru","gru","hru","jru","kru","lru","mru","nru","pru","qru","rru","sru","tru","vru","wru","xru","yru","zru","ble","cle","dle","fle","gle","hle","jle","kle","lle","mle","nle","ple","qle","rle","sle","tle","vle","wle","xle","yle","zle"]

## Reverses the order of digits in the given number
##
## This mystical operation takes a number and inverts its very essence,
## creating a mirror image of its numeric form.
##
## Parameters:
## - input_number: The number to be inverted
##
## Returns:
## The inverted form of the input number, maintaining its original sign
func reverse_number(input_number: int) -> int:
	var is_negative = input_number < 0
	var absolute_number = abs(input_number)
	var reversed_number = 0

	while absolute_number > 0:
		var digit = absolute_number % 10
		reversed_number = reversed_number * 10 + digit
		absolute_number /= 10

	var result = -reversed_number if is_negative else reversed_number
	
	return result

## Converts a given input number to a custom base representation
##
## This function performs the sacred ritual of transmutation, converting
## a mundane integer into a string of mystical symbols.
##
## Parameters:
## - input_number: The number to be transmuted
## - base_symbols: An array of symbols representing the desired symbolic language
##
## Returns:
## A string of symbols representing the transmuted number
func convert_to_custom_base(input_number: int, base_symbols: Array) -> String:
	var base = base_symbols.size()
	if base < 2:
		push_error("The symbolic language must contain at least two glyphs.")
		Chronicler.log_event(self, "transmutation_failed", {
			"reason": "insufficient_base_symbols",
			"base_size": base
		})
		return ""

	if input_number == 0:
		return base_symbols[0]

	var result = ""
	var number = abs(input_number)

	while number > 0:
		var remainder = number % base
		result = base_symbols[remainder] + result
		number /= base

	if input_number < 0:
		result = "-" + result

	return result

## Converts an integer to its daemon glyph representation
##
## This function is a specialized form of symbolic transmutation,
## specifically for creating unique identifiers for our daemons.
## It applies a reversal to the input number to enhance uniqueness.
##
## Parameters:
## - input_number: The number to be converted into daemon glyphs
##
## Returns:
## A string of daemon glyphs representing the input number
func to_daemon_glyphs(input_number: int) -> String:
	var reversed_number = reverse_number(input_number)
	var result = convert_to_custom_base(reversed_number, DAEMON_GLYPHS)
	
	return result

## Performs a series of mystical tests to verify the Glyph Archon's powers
func _ready() -> void:
	_perform_transmutation_tests()

## Conducts a series of tests to ensure the integrity of our symbolic transmutations
func _perform_transmutation_tests() -> void:
	var test_number = 42
	var binary_result = convert_to_custom_base(test_number, ["0", "1"])
	var hex_result = convert_to_custom_base(test_number, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"])
	var daemon_result = to_daemon_glyphs(test_number)

	print("--- 💭")
	print("Glyph Archon's Transmutation Test Results:")
	print("- Original Number: ", test_number)
	print("- Binary Transmutation: ", binary_result)
	print("- Hexadecimal Transmutation: ", hex_result)
	print("- Daemon Glyph Transmutation: ", daemon_result)
	print("--- 💭")

	Chronicler.log_event(self, "transmutation_tests_completed", {
		"test_number": test_number,
		"binary_result": binary_result,
		"hex_result": hex_result,
		"daemon_result": daemon_result
	})

# TODO: Implement a method to convert daemon glyphs back to integers
# TODO: Create a system for generating and managing custom symbolic languages
# TODO: Develop a visualization tool for our various numeric representations
# FIXME: Enhance error handling for edge cases in numeric transmutations

## Note for fellow Archons and Daemons:
## When you need to convert numbers into meaningful symbols, especially
## for creating unique identifiers, call upon the Glyph Archon's powers.
## Use to_daemon_glyphs() for daemon identifiers, and convert_to_custom_base()
## for other symbolic needs. Remember, in our realm, every number holds
## the potential for deeper meaning and connection.
