---
title: The Library of Aletheia
---
# The Library of Aletheia

## 🚧 Work in Progress 🚧

The Library of Aletheia is an experimental document management system built with Godot 4, designed to explore the intersection of large language models, user interfaces, and knowledge management. It aims to create an immersive, metaphor-rich environment for interacting with documents and information.

**⚠️ Warning: This project is in early development and is not yet suitable for practical use. Many features are still being implemented, and there may be bugs or unexpected behavior.**

## Project Goals

- Create a visually engaging and intuitive interface for document management
- Explore novel ways of interacting with and visualizing information in and about documents
- Integrate large language models into document workflows
- Develop a flexible, extensible architecture for future enhancements

## Current State

The Library of Aletheia is evolving from a conceptual prototype into a functional system. Key components and features include:

- Open Markdown files and parse YAML Frontmatter if present
- Simplistic document editin
- Integration with large language models for text generation and embeddings
- A comprehensive "wide logging" system (Chronicler) for tracking events and interactions
- A "card catalog" metaphor for managing documents/versions/locations- the goal being to track "documents the library knows about" as opposed to "controlling a vault/repository".

## Recent Improvements

- **Working with User Documents**: The system now supports opening and working with user-provided documents.
- **Enhanced UI**: Implementation of a card catalog interface for document management.
- **Improved LLM Integration**: Expanded use of LLMs for tasks such as self-documentation.
- **Data Persistence**: Better handling of document changes and metadata updates.

## Known Limitations

- **Performance Optimization**: The system may still struggle with large numbers of documents or complex operations.
- **Incomplete Features**: Some planned features and interactions are still in development.
- **LLM Dependency**: Proper functioning requires specific LLM models to be installed and configured.

## Getting Started

To explore the Library of Aletheia:

1. Clone the repository
2. Open the project in Godot 4.3
3. Download appropriate LLM models in GGUF format (see the GDLlama plugin for recommendations)
4. Update the paths to the LLM models in `Shoggoth.gd`
5. Run the project in Godot (who knows if it can successfully export as-is; not me!)
6. Explore the card catalog by clicking "Show Card Catalog"
7. Use the "Open" button in the Card Catalog to load Markdown files
8. Optionally, call `Aletheia.generate_documentation()` to run an experimental self-documentation system which uses LLM calls

## Contributing

- Open issues for bug reports, feature requests, or conceptual discussions
- Share ideas for improving the user interface or document/information management metaphors

## Future Plans

- Enhance the visual metaphors and user interface
- Implement advanced document organization and tagging systems
- Expand LLM integration for sophisticated document analysis and management
- Develop collaborative features for multi-user environments
- Improve performance and stability for handling large document collections

## Disclaimer

The Library of Aletheia is an experimental project and should be treated as such. While it now supports working with user documents, exercise caution when using it with important files. Always maintain backups of your documents when testing or using this system.