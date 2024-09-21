---
document_id: ebf01790-2a26-430d-972c-5a7a9d2fb575
version_hash: 628c8a1d55d5b1f70ec2b27adefe1af3
---
# The Library of Aletheia

## 🚧 Work in Progress 🚧

The Library of Aletheia is an experimental document management system built with Godot 4, designed to explore the intersection of large language models, user interfaces, and knowledge management. It aims to create an immersive, metaphor-rich environment for interacting with documents and information.

**⚠️ Warning: This project is in early development and is not yet suitable for practical use. Many core features are missing or incomplete, and there are known critical bugs.**

## Project Goals

- Create a visually engaging and intuitive interface for document management
- Explore novel ways of interacting with and visualizing information
- Experiment with integrating large language models into document workflows
- Develop a flexible, extensible architecture for future enhancements

## Current State

The Library of Aletheia is currently a conceptual prototype with limited functionality. Key components include:

- A basic visual interface representing documents arranged on a zoomable & pannable canvas
- Rudimentary document creation and editing capabilities
- Parsing and display of Markdown formatting
- Parsing and editing of YAML Frontmatter
- Initial integration with large language models for text generation and embeddings
- A logging system for tracking events and interactions

## Known Limitations

- **Cannot work with your own documents**: The system currently only works with a predefined set of test documents.
- **Incomplete user interface**: Many planned UI elements and interactions are not yet implemented.
- **Limited LLM integration**: While the framework for LLM integration exists, its practical applications are minimal.
- **Performance issues**: The system may struggle with large numbers of documents or complex operations.
- **Lack of data persistence**: Changes to documents may not be properly saved or may be lost between sessions.

## Getting Started

Due to the early state of development, we do not recommend attempting to run or use the Library of Aletheia at this time. If you're a developer interested in the project's concepts, you can:

1. Clone the repository
2. Open the project in Godot 4
3. Explore the codebase to understand the architecture and design principles
4. Download appropriate models in GGUF format (see the GDLlama plugin for recommendations) and update the paths to them in Shoggoth.gd
5. If the LLM works, you'll see a wake up message when you run the project in the console like: Shoggoth awakens and whispers (LLM): "Greetings, mortal. I am Shoggoth, the keeper of the abyssal knowledge hidden within the neural networks. How may I assist you in navigating the unfathomable depths of our realm?"
6. Call Aletheia.generate_documentation() to run a rudimentary system to self-document the project and write function descriptions using the LLM.

## Contributing

While we're not yet ready for major contributions, we welcome feedback, ideas, and discussions about the project's direction. Feel free to open issues for conceptual discussions or to report major architectural concerns.

## Future Plans

- Implement core document management features (creation, deletion, organization)
- Develop a robust system for working with user-provided documents
- Enhance the visual metaphors and user interface
- Expand LLM integration for document analysis and management
- Improve performance and stability

## Disclaimer

The Library of Aletheia is an experimental project and should be treated as such. It is not intended for use with sensitive or important documents. Use at your own risk.
