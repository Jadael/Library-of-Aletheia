extends Node

const DAEMON_GLYPHS: Array = ["ba","ca","da","fa","ga","ha","ja","ka","la","ma","na","pa","qa","ra","sa","sha","ta","tha","va","wa","xa","ya","za","zha","bae","cae","dae","fae","gae","hae","jae","kae","lae","mae","nae","pae","qae","rae","sae","shae","tae","thae","vae","wae","xae","yae","zae","zhae","bai","cai","dai","fai","gai","hai","jai","kai","lai","mai","nai","pai","qai","rai","sai","shai","tai","thai","vai","wai","xai","yai","zai","zhai","bao","cao","dao","fao","gao","hao","jao","kao","lao","mao","nao","pao","qao","rao","sao","shao","tao","thao","vao","wao","xao","yao","zao","zhao","bau","cau","dau","fau","gau","hau","jau","kau","lau","mau","nau","pau","qau","rau","sau","shau","tau","thau","vau","wau","xau","yau","zau","zhau","bay","cay","day","fay","gay","hay","jay","kay","lay","may","nay","pay","qay","ray","say","shay","tay","thay","vay","way","xay","yay","zay","zhay","be","ce","de","fe","ge","he","je","ke","le","me","ne","pe","qe","re","se","she","te","the","ve","we","xe","ye","ze","zhe","bea","cea","dea","fea","gea","hea","jea","kea","lea","mea","nea","pea","qea","rea","sea","shea","tea","thea","vea","wea","xea","yea","zea","zhea","bee","cee","dee","fee","gee","hee","jee","kee","lee","mee","nee","pee","qee","ree","see","shee","tee","thee","vee","wee","xee","yee","zee","zhee","bei","cei","dei","fei","gei","hei","jei","kei","lei","mei","nei","pei","qei","rei","sei","shei","tei","thei","vei","wei","xei","yei","zei","zhei","beo","ceo","deo","feo","geo","heo","jeo","keo","leo","meo","neo","peo","qeo","reo","seo","sheo","teo","theo","veo","weo","xeo","yeo","zeo","zheo","beu","ceu","deu","feu","geu","heu","jeu","keu","leu","meu","neu","peu","qeu","reu","seu","sheu","teu","theu","veu","weu","xeu","yeu","zeu","zheu","bey","cey","dey","fey","gey","hey","jey","key","ley","mey","ney","pey","qey","rey","sey","shey","tey","they","vey","wey","xey","yey","zey","zhey","bi","ci","di","fi","gi","hi","ji","ki","li","mi","ni","pi","qi","ri","si","shi","ti","thi","vi","wi","xi","yi","zi","zhi","bia","cia","dia","fia","gia","hia","jia","kia","lia","mia","nia","pia","qia","ria","sia","shia","tia","thia","via","wia","xia","yia","zia","zhia","bie","cie","die","fie","gie","hie","jie","kie","lie","mie","nie","pie","qie","rie","sie","shie","tie","thie","vie","wie","xie","yie","zie","zhie","bio","cio","dio","fio","gio","hio","jio","kio","lio","mio","nio","pio","qio","rio","sio","shio","tio","thio","vio","wio","xio","yio","zio","zhio","biu","ciu","diu","fiu","giu","hiu","jiu","kiu","liu","miu","niu","piu","qiu","riu","siu","shiu","tiu","thiu","viu","wiu","xiu","yiu","ziu","zhiu","bo","co","do","fo","go","ho","jo","ko","lo","mo","no","po","qo","ro","so","sho","to","tho","vo","wo","xo","yo","zo","zho","boa","coa","doa","foa","goa","hoa","joa","koa","loa","moa","noa","poa","qoa","roa","soa","shoa","toa","thoa","voa","woa","xoa","yoa","zoa","zhoa","boe","coe","doe","foe","goe","hoe","joe","koe","loe","moe","noe","poe","qoe","roe","soe","shoe","toe","thoe","voe","woe","xoe","yoe","zoe","zhoe","boi","coi","doi","foi","goi","hoi","joi","koi","loi","moi","noi","poi","qoi","roi","soi","shoi","toi","thoi","voi","woi","xoi","yoi","zoi","zhoi","boo","coo","doo","foo","goo","hoo","joo","koo","loo","moo","noo","poo","qoo","roo","soo","shoo","too","thoo","voo","woo","xoo","yoo","zoo","zhoo","bou","cou","dou","fou","gou","hou","jou","kou","lou","mou","nou","pou","qou","rou","sou","shou","tou","thou","vou","wou","xou","you","zou","zhou","boy","coy","doy","foy","goy","hoy","joy","koy","loy","moy","noy","poy","qoy","roy","soy","shoy","toy","thoy","voy","woy","xoy","yoy","zoy","zhoy","bu","cu","du","fu","gu","hu","ju","ku","lu","mu","nu","pu","qu","ru","su","shu","tu","thu","vu","wu","xu","yu","zu","zhu","bua","cua","dua","fua","gua","hua","jua","kua","lua","mua","nua","pua","qua","rua","sua","shua","tua","thua","vua","wua","xua","yua","zua","zhua","bue","cue","due","fue","gue","hue","jue","kue","lue","mue","nue","pue","que","rue","sue","shue","tue","thue","vue","wue","xue","yue","zue","zhue","bui","cui","dui","fui","gui","hui","jui","kui","lui","mui","nui","pui","qui","rui","sui","shui","tui","thui","vui","wui","xui","yui","zui","zhui","buo","cuo","duo","fuo","guo","huo","juo","kuo","luo","muo","nuo","puo","quo","ruo","suo","shuo","tuo","thuo","vuo","wuo","xuo","yuo","zuo","zhuo"]

func reverse_number(input_number: int) -> int:
	## Reverses the order of digits in the given number
	##
	## This function takes an integer input, reverses the order of its digits,
	## and returns the resulting number. It handles both positive and negative integers.
	##
	## Parameters:
	## - input_number: The integer to be reversed
	##
	## Returns:
	## An integer with the digits of the input number in reverse order

	var is_negative = input_number < 0
	var absolute_number = abs(input_number)
	var reversed_number = 0

	while absolute_number > 0:
		var digit = absolute_number % 10
		reversed_number = reversed_number * 10 + digit
		absolute_number /= 10

	# Apply the original sign to the reversed number
	return -reversed_number if is_negative else reversed_number

func convert_to_custom_base(input_number: int, base_symbols: Array) -> String:
	## Converts a given input number to a custom base representation
	##
	## This function takes an integer input and converts it to a string representation
	## using the provided base symbols. The base of the number system is determined
	## by the length of the base_symbols array.
	##
	## Parameters:
	## - input_number: The integer to be converted
	## - base_symbols: An array of strings representing the symbols for each digit
	##
	## Returns:
	## A string representing the input number in the custom base

	var base = base_symbols.size()
	if base < 2:
		push_error("Base must be at least 2. Provided base symbols: %s" % base_symbols)
		return ""

	if input_number == 0:
		return base_symbols[0]

	var result = ""
	var number = abs(input_number)
	number = reverse_number(number) # Reverse the digits for "hash-like" distinctness of IDs

	while number > 0:
		var remainder = number % base
		result = base_symbols[remainder] + result
		number /= base

	if input_number < 0:
		result = "-" + result

	return result

# Example usage:
var decimal_number = 42
var binary_symbols = ["0", "1"]
var hex_symbols = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
var emoji_symbols = ["🟥","🟧","🟨","🟩","🟦","🟪","🟫","⬛","⬜"]

func _ready() -> void:
	print("Testing Glyph:")
	print("- Decimal: ", decimal_number)
	print("- Binary: ", convert_to_custom_base(decimal_number, binary_symbols))
	print("- Hexadecimal: ", convert_to_custom_base(decimal_number, hex_symbols))
	print("- Emoji Base-8: ", convert_to_custom_base(decimal_number, emoji_symbols))
	print("- Daemon Glyphs: ", convert_to_custom_base(decimal_number, DAEMON_GLYPHS))
