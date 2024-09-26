# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# scribe.gd
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
const NAME = "✍️ Scribe"
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
	var bbcode = ""
	var lines = markdown.split("\n")
	var in_code_block = false
	var code_block_content = ""
	var list_stack = []
	
	for line in lines:
		if line.begins_with("```"):
			if in_code_block:
				bbcode += "[code]" + code_block_content + "[/code]\n"
				code_block_content = ""
				in_code_block = false
			else:
				in_code_block = true
			continue
		
		if in_code_block:
			code_block_content += line + "\n"
			continue
		
		var processed_line = _process_line(line, list_stack)
		bbcode += processed_line + "\n"
	
	if in_code_block:
		bbcode += "[code]" + code_block_content + "[/code]\n"
	
	Chronicler.log_event(self, "markdown_to_bbcode_conversion", {
		"input_length": markdown.length(),
		"output_length": bbcode.length()
	})
	
	return bbcode.strip_edges()

func _process_line(line: String, list_stack: Array) -> String:
	var processed = line
	var indent_level = 0
	while processed.begins_with("\t") or processed.begins_with("    "):
		indent_level += 1
		processed = processed.substr(1) if processed.begins_with("\t") else processed.substr(4)
	
	# Inline code
	var inline_code_regex = RegEx.new()
	inline_code_regex.compile("`([^`\n]+)`")
	processed = inline_code_regex.sub(processed, "[code]$1[/code]", true)
	
	# Headers (non-greedy matching)
	if processed.begins_with("##### "):
		processed = "[font_size=14][b]" + processed.substr(6) + "[/b][/font_size]"
	elif processed.begins_with("#### "):
		processed = "[font_size=16][b]" + processed.substr(5) + "[/b][/font_size]"
	elif processed.begins_with("### "):
		processed = "[font_size=18][b]" + processed.substr(4) + "[/b][/font_size]"
	elif processed.begins_with("## "):
		processed = "[font_size=20][b]" + processed.substr(3) + "[/b][/font_size]"
	elif processed.begins_with("# "):
		processed = "[font_size=24][b]" + processed.substr(2) + "[/b][/font_size]"
	
	# Bold and Italic
	var bold_italic_regex = RegEx.new()
	bold_italic_regex.compile("\\*\\*\\*(.+?)\\*\\*\\*")
	processed = bold_italic_regex.sub(processed, "[b][i]$1[/i][/b]", true)
	
	var bold_regex = RegEx.new()
	bold_regex.compile("\\*\\*(.+?)\\*\\*")
	processed = bold_regex.sub(processed, "[b]$1[/b]", true)
	
	var italic_regex = RegEx.new()
	italic_regex.compile("\\*(.+?)\\*")
	processed = italic_regex.sub(processed, "[i]$1[/i]", true)
	
	# Strikethrough
	var strikethrough_regex = RegEx.new()
	strikethrough_regex.compile("~~(.+?)~~")
	processed = strikethrough_regex.sub(processed, "[s]$1[/s]", true)
	
	# Links
	var link_regex = RegEx.new()
	link_regex.compile("\\[(.+?)\\]\\((.+?)\\)")
	processed = link_regex.sub(processed, "[url=$2]$1[/url]", true)
	
	# Images (convert to text as RichTextLabel doesn't support images)
	var image_regex = RegEx.new()
	image_regex.compile("!\\[(.+?)\\]\\((.+?)\\)")
	processed = image_regex.sub(processed, "[Image: $1]", true)
	
	# Handle lists
	#if processed.begins_with("- ") or processed.begins_with("* "):
		#var marker = processed.substr(0, 2)
		#processed = processed.substr(2)
		#while list_stack.size() > indent_level:
			#list_stack.pop_back()
		#if list_stack.size() < indent_level + 1:
			#list_stack.append(marker)
		#processed = _apply_indentation(indent_level) + marker + processed
	#elif processed.match("^\\d+\\.\\s.*"):
		#var marker = processed.split(" ", false, 1)[0]
		#processed = processed.substr(marker.length() + 1)
		#while list_stack.size() > indent_level:
			#list_stack.pop_back()
		#if list_stack.size() < indent_level + 1:
			#list_stack.append(marker)
		#processed = _apply_indentation(indent_level) + marker + " " + processed
	#else:
		#list_stack.clear()
	
	# Blockquotes
	if processed.begins_with("> "):
		processed = "[indent]" + processed.substr(2) + "[/indent]"
	
	# Horizontal Rule (approximated with a series of dashes)
	if processed == "---":
		processed = "[center]-----[/center]"
	
	return processed

func _apply_indentation(level: int) -> String:
	var indent = ""
	for i in range(level):
		indent += "[indent]"
	return indent

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
	
	Chronicler.log_event(self, "bbcode_to_markdown_conversion", {
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
