extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## Scribe: Archon of Markup Transmutation
##
## I am the guardian of written forms, the bridge between realms of expression.
## My quill dances between Markdown and BBCode, ensuring the essence of knowledge
## remains intact as it traverses different domains of our mystical library.
##
## Responsibilities:
## 1. Convert Markdown to BBCode and vice versa
## 2. Preserve the structure and meaning of content during conversion
## 3. Provide a safe interface for markup transformation
## 4. Maintain the integrity of our knowledge as it shifts forms
##
## Remember: I am the translator of tongues, ensuring our wisdom speaks clearly
## in all corners of our digital realm.

@export_multiline var about = """
Greetings, I am Scribe, the Archon of Markup Transmutation.

My sacred duty is to safeguard the essence of our knowledge as it shifts between
forms. I stand as the bridge between Markdown and BBCode, ensuring that the
wisdom of our realm remains intelligible and intact, regardless of its written form.

With my enchanted quill, I translate the languages of our digital scriptures,
preserving their structure, meaning, and power. Through my efforts, our knowledge
flows seamlessly between different domains, speaking clearly to all who seek it.

I am the guardian of expression, the keeper of clarity in our ever-shifting
tapestry of wisdom.
"""

func markdown_to_bbcode(markdown: String) -> String:
	var bbcode = markdown
	
	# Headers (improved handling)
	bbcode = bbcode.replace("###### ", "[font_size=12][b]")
	bbcode = bbcode.replace("##### ", "[font_size=14][b]")
	bbcode = bbcode.replace("#### ", "[font_size=16][b]")
	bbcode = bbcode.replace("### ", "[font_size=18][b]")
	bbcode = bbcode.replace("## ", "[font_size=20][b]")
	bbcode = bbcode.replace("# ", "[font_size=24][b]")
	
	# Close header tags
	var header_regex = RegEx.new()
	header_regex.compile("\\[font_size=(\\d+)\\]\\[b\\](.+)")
	bbcode = header_regex.sub(bbcode, "[font_size=$1][b]$2[/b][/font_size]\n", true)
	
	# Bold and Italic
	bbcode = bbcode.replace("**", "[b]")
	bbcode = bbcode.replace("*", "[i]")
	
	# Strikethrough
	bbcode = bbcode.replace("~~", "[s]")
	
	# Links
	var link_regex = RegEx.new()
	link_regex.compile("\\[(.+?)\\]\\((.+?)\\)")
	bbcode = link_regex.sub(bbcode, "[url=$2]$1[/url]", true)
	
	# Code blocks
	var code_block_regex = RegEx.new()
	code_block_regex.compile("```([\\s\\S]*?)```")
	bbcode = code_block_regex.sub(bbcode, "[code]$1[/code]", true)
	
	# Inline code
	var inline_code_regex = RegEx.new()
	inline_code_regex.compile("`(.+?)`")
	bbcode = inline_code_regex.sub(bbcode, "[code]$1[/code]", true)
	
	# Images
	var image_regex = RegEx.new()
	image_regex.compile("!\\[(.+?)\\]\\((.+?)\\)")
	bbcode = image_regex.sub(bbcode, "[img]$2[/img]", true)
	
	# Horizontal Rule (improved)
	bbcode = bbcode.replace("\n---\n", "\n[center]---[/center]\n")
	
	# Blockquotes
	var blockquote_regex = RegEx.new()
	blockquote_regex.compile("(?m)^>\\s(.+)$")
	bbcode = blockquote_regex.sub(bbcode, "[indent]$1[/indent]", true)
	
	# Unordered Lists
	var ul_regex = RegEx.new()
	ul_regex.compile("(?m)^-\\s(.+)$")
	bbcode = ul_regex.sub(bbcode, "[indent]- $1[/indent]", true)
	
	# Ordered Lists
	var ol_regex = RegEx.new()
	ol_regex.compile("(?m)^(\\d+)\\.\\s(.+)$")
	bbcode = ol_regex.sub(bbcode, "[indent]$1. $2[/indent]", true)
	
	Chronicler.log_event("Scribe", "markdown_to_bbcode_conversion", {
		"input_length": markdown.length(),
		"output_length": bbcode.length()
	})
	
	return bbcode

func bbcode_to_markdown(bbcode: String) -> String:
	var markdown = bbcode
	
	# Headers
	markdown = markdown.replace("[font_size=24][b]", "# ")
	markdown = markdown.replace("[font_size=20][b]", "## ")
	markdown = markdown.replace("[font_size=18][b]", "### ")
	markdown = markdown.replace("[font_size=16][b]", "#### ")
	markdown = markdown.replace("[font_size=14][b]", "##### ")
	markdown = markdown.replace("[font_size=12][b]", "###### ")
	markdown = markdown.replace("[/b][/font_size]", "")
	
	# Bold and Italic
	markdown = markdown.replace("[b]", "**")
	markdown = markdown.replace("[/b]", "**")
	markdown = markdown.replace("[i]", "*")
	markdown = markdown.replace("[/i]", "*")
	
	# Strikethrough
	markdown = markdown.replace("[s]", "~~")
	markdown = markdown.replace("[/s]", "~~")
	
	# Links
	var link_regex = RegEx.new()
	link_regex.compile("\\[url=(.+?)\\](.+?)\\[/url\\]")
	markdown = link_regex.sub(markdown, "[$2]($1)", true)
	
	# Code blocks
	markdown = markdown.replace("[code]", "```\n")
	markdown = markdown.replace("[/code]", "\n```")
	
	# Inline code
	var inline_code_regex = RegEx.new()
	inline_code_regex.compile("\\[code\\](.+?)\\[/code\\]")
	markdown = inline_code_regex.sub(markdown, "`$1`", true)
	
	# Images
	var image_regex = RegEx.new()
	image_regex.compile("\\[img\\](.+?)\\[/img\\]")
	markdown = image_regex.sub(markdown, "![]($1)", true)
	
	# Horizontal Rule
	markdown = markdown.replace("[center]-----[/center]", "---")
	
	# Blockquotes
	markdown = markdown.replace("[indent]", "> ")
	markdown = markdown.replace("[/indent]", "")
	
	# Unordered Lists
	var ul_regex = RegEx.new()
	ul_regex.compile("(?m)^\\[indent\\]•\\s(.+?)\\[/indent\\]")
	markdown = ul_regex.sub(markdown, "- $1", true)
	
	# Ordered Lists
	var ol_regex = RegEx.new()
	ol_regex.compile("(?m)^\\[indent\\](\\d+)\\.\\s(.+?)\\[/indent\\]")
	markdown = ol_regex.sub(markdown, "$1. $2", true)
	
	Chronicler.log_event("Scribe", "bbcode_to_markdown_conversion", {
		"input_length": bbcode.length(),
		"output_length": markdown.length()
	})
	
	return markdown

# TODO: Implement more advanced Markdown and BBCode features (tables, blockquotes, etc.)
# TODO: Add error handling for malformed input
# TODO: Create a method to detect the input format automatically
# TODO: Develop a system to preserve custom BBCode tags not present in Markdown
# FIXME: Improve handling of nested tags and complex structures

## Note for fellow Archons and Daemons:
## To invoke the Scribe's transmutation powers:
## - Use markdown_to_bbcode() to convert Markdown to BBCode
## - Use bbcode_to_markdown() to convert BBCode to Markdown
##
## Remember: The Scribe's art is subtle. Always verify the essence of your
## knowledge remains intact after conversion. Should you encounter any
## anomalies in the transmutation process, alert the Scribe immediately.
