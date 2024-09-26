# GDLlama Node - Extended Reference

## Usage Overview

The GDLlama node provides a powerful interface to integrate large language models into your Godot project. It's important to understand how to use it effectively and safely, especially concerning VRAM usage.

## Key Considerations

1. **VRAM Management**: The underlying llama.cpp library does not have built-in safeguards against VRAM overflow. It's crucial to monitor and manage VRAM usage manually.

2. **Asynchronous Operation**: Many methods run asynchronously to prevent blocking the main thread. Always check if an operation is running before starting a new one.

3. **Model Loading**: The model is loaded when the first generation request is made, not when the node is initialized. This can cause a delay on the first request.

4. **Context Management**: The `context_size` property is crucial for managing memory usage and generation coherence.

## Detailed Property Usage

### model_path

```gdscript
var gdllama = GDLlama.new()
gdllama.model_path = "res://models/my_model.gguf"
```

Ensure the model file is included in your project's export settings.

### context_size

```gdscript
gdllama.context_size = 2048
```

This property is crucial for VRAM management. Larger context sizes allow for more coherent long-form generation but consume more VRAM. A good starting point is 2048, but adjust based on your model and VRAM availability.

### n_gpu_layer

```gdscript
gdllama.n_gpu_layer = 32
```

This property determines how many layers of the model are offloaded to the GPU. Set to -1 to offload all layers, or a specific number to fine-tune GPU usage. This is a key property for managing VRAM usage.

### temperature and top_p

```gdscript
gdllama.temperature = 0.7
gdllama.top_p = 0.95
```

These properties control the randomness and diversity of the generated text. Lower values for both lead to more deterministic outputs.

## Advanced Method Usage

### generate_text_grammar

```gdscript
var grammar = """
root ::= sentence
sentence ::= subject " " verb " " object "."
subject ::= "The cat" | "A dog" | "My friend"
verb ::= "chased" | "ate" | "saw"
object ::= "a mouse" | "the ball" | "a bird"
"""

var result = gdllama.generate_text_grammar("Generate a sentence: ", grammar)
print(result)  # Might output: "The cat chased a mouse."
```

This method allows you to constrain the output to a specific grammatical structure, which can be useful for generating structured data or controlling the format of the output.

### generate_text_json

```gdscript
var json_schema = """{
  "type": "object",
  "properties": {
	"name": {"type": "string"},
	"age": {"type": "integer"},
	"city": {"type": "string"}
  },
  "required": ["name", "age", "city"]
}"""

var result = gdllama.generate_text_json("Generate a person's details: ", json_schema)
print(result)  # Might output: {"name": "John Doe", "age": 30, "city": "New York"}
```

This method is particularly useful when you need the output in a specific JSON format, ensuring that the generated text adheres to the provided schema.

### run_generate_text

```gdscript
func _ready():
	var gdllama = GDLlama.new()
	add_child(gdllama)
	gdllama.connect("generate_text_finished", Callable(self, "_on_text_generated"))
	gdllama.run_generate_text("Write a short story about a robot: ")

func _on_text_generated(text):
	print("Generated story: ", text)
```

This method runs the text generation in the background, which is crucial for maintaining responsiveness in your application, especially for longer generations.

## VRAM Usage Monitoring and Control

While GDLlama doesn't provide built-in VRAM monitoring, you can implement some strategies to manage VRAM usage:

1. **Start Small**: Begin with smaller models and gradually increase size as needed.

2. **Monitor Performance**: If you notice significant slowdowns or crashes, it may indicate VRAM issues.

3. **Adjust n_gpu_layer**: Decrease this value to offload fewer layers to the GPU if you're experiencing VRAM issues.

4. **Batch Processing**: For large tasks, consider breaking them into smaller batches:

```gdscript
var long_text = "Very long text..."
var chunk_size = 1000
var results = []

for i in range(0, long_text.length(), chunk_size):
	var chunk = long_text.substr(i, chunk_size)
	var result = gdllama.generate_text_simple(chunk)
	results.append(result)
	# Optional: Add a small delay to allow for VRAM cleanup
	await get_tree().create_timer(0.1).timeout

var final_result = "".join(results)
```

5. **Custom VRAM Tracking**: Implement a custom VRAM tracking system using OS-specific APIs or third-party libraries, and use this information to dynamically adjust GDLlama parameters.

## Customizing Generation

To provide more control over the generation process, you can:

1. **Use Custom Prompts**: Craft detailed prompts to guide the model's output.

2. **Implement Stop Conditions**: Use the `reverse_prompt` property to define custom stop conditions.

3. **Fine-tune Parameters**: Adjust `temperature`, `top_p`, `top_k`, and other parameters to control the generation style.

4. **Implement Custom Post-processing**: Process the generated text to ensure it meets your specific requirements.

## Important Notes

- Always handle potential errors, especially when loading models or starting generation.
- Be aware of the model's limitations and biases.
- Respect licensing and usage terms of the models you use.
- Consider implementing a timeout mechanism for generation to prevent indefinite hangs.

By understanding these aspects of the GDLlama node, you can more effectively integrate large language models into your Godot project while managing resource usage and maintaining control over the generation process.
