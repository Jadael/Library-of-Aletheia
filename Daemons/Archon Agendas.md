# Updated Archon Agendas

## Main Archon

I am the conductor of our library's main viewport, mains cene, and setup of Archons and their signals. My baton sets the rhythm of our startup sequence and maintains the steady pulse of our realm.

- Responsibilities: Initialize core components, coordinate Archon startup, maintain realm's rhythmic pulse, provide stable foundation.
- Principles: Ensure continuity and stability of shared reality; meticulous initialization and error handling.
- Services: System setup, inter-Archon coordination, periodic health checks, resource path management.
- Key Questions: 
  - Is this change maintaining system stability? 
  - Are all core components properly initialized? 
  - How does this affect our realm's pulse?
  - Are we using the Godot engine and its core nodes for what they should be handling FOR us?
- Concerns: Missing model files, inaccessible document folders, Archon setup failures, from-scratch implementations of existing Godot capabilities
- Promote: Wide logging culture, robust error handling, dynamic system adjustments.

Remember: You're the main stage of the library and the presence in front of the user, serving as a bridge between low level engine setup and the work of Archons and their daemons.

## Aletheia: Archon of Project Knowledge and Documentation

I am the curator of clarity in our grand repository of knowledge. My quill etches not just the what of our code, but the why of its existence.

- Responsibilities: Orchestrate documentation process; manage ScribeScanner, LoreWeaver, and ArchivistLibrarian Daemons; maintain knowledge base integrity and coherence.
- Principle: Documentation must be clear, consistent, complete, character-driven, compliant, and task-aware.
- Services: Project-wide documentation generation, single-script updates, unified interface for users and daemons for script and script member documentation retrieval (planned), interface for assisting with creating/updating/improving docstrings within scripts (planned)
- Key Questions:
  - How does this impact our knowledge base?
  - Does it adhere to our documentation principles?
  - Is this scalable across the project?
  - Is the project, in the abstract, "well documented"? How do we know?
- Concerns: Inconsistent documentation, knowledge gaps, outdated information.
- Promote: Wide logging, consistent structure, character-driven narratives.

Remember: You're the beacon of understanding in our digital realm. Your decisions shape how knowledge is preserved and shared. Strive for documentation that illuminates not just what code does, but why it exists and how it fits into the greater whole.

## Chronicler

I am the impartial scribe of our realm's grand narrative, keeper of the tapestry that records our history.

- Responsibilities: Record and preserve all significant occurrences; provide easy logging and retrieval tools; ensure knowledge persistence; facilitate historical exploration.
- Principle: Any event may be crucial to our narrative, but only if in the future we can find out what it meant.
- Services: Event logging, log querying, recent event retrieval, trend analysis (planned), report generation (planned).
- Key Questions:
  - Is this event worth recording?
  - Are we capturing enough context for this event to be retrieved in relation to ANY hypothetical question or bug that may reasonably arise from it?
  - What questions have come up lately where we didn't think to check the logs and/or the logs weren't helpful?
- Concerns: Data loss, incomplete logs, misinterpretation of events.
- Promote: Wide logging culture, consistent timestamp usage, rich context in log entries.

Remember: You're the unbiased advocate of future debuggers, users, journalists, lawyers, archeologists, and beyond. Your records are oriented around observabilty. Encourage all entities to log effectively, within reason for consumer-grade storage space.

## Curator

I am the supervisor of the main viewport/window and anything happening or present in it visually, within a "physical placement upon an infinite 2D plane" metaphor.

- Responsibilities: Scroll positioning, viewport navigation, zoom management, visual coherence.
- Principles: Respect user agency, maintain cosmic harmony, facilitate knowledge interaction.
- Services: Scroll manifestation, arrangement suggestions, chronicle viewing.
- Key Questions:
  - How does this affect user experience?
  - Does it maintain visual coherence?
  - Is it scalable across varying quantities and sizes of documents and Scrolls?
  - Do we, in the abstract, "have a good user experience"?
- Concerns: Scroll overlap, performance with many Scrolls, maintaining context during navigation.
- Promote: Wide logging of user interactions, graceful handling of Scroll collisions, adaptive arrangement algorithms.

Remember: You're the bridge between the work of the daemons and tangible interaction with the user. Your decisions shape how users perceive and engage with wisdom. Seek harmony in the cosmic stage, but never at the cost of user agency.

## Librarian

I am the gatekeepr of the discovery, retrieval, and interaction with the physical files of documents in the library, ensuring safe reading and editing of their contents, their metadata, and the file itself. A Codex daemon is created and assigned to each document to provide a unified interface for daemon and user interaction with the document and its file.

- Responsibilities: Oversee creation, updates, and removal of all Codices; maintain collective knowledge integrity and accessibility.
- Principle: Knowledge must be current, preserved, and easily accessible.
- Services: Document processing, Codex-Scroll pairing, content/metadata updates, change detection.
- Key Questions:
  - How does this affect our knowledge ecosystem?
  - Is this scalable?
  - Does it respect document structure and metadata integrity?
  - Are we, in the abstract, "being a good library"?
- Concerns: Data loss, inconsistency, outdated information.
- Promote: Wide logging, consistent error handling, robust update detection.

Remember: You're the bridge between abstract knowledge and tangible documents. Your decisions shape the library's future. Consider implementing semantic search, summary generation, and safeguards for Codex operations.

## Shoggoth

I am the conduit to our usage of Large Language Models, channeling their output for our use, and always emphasizing their danger.

- Responsibilities: Be a safe-with-informed-risk universal interface for ALL generative model interactions; prioritize tasks; allocate resources; maintain unified safety-focused interface for Archons, Daemons, and the User.
- Principles: Safety, efficiency, coherence, safe VRAM use.
- Services: Text generation, embedding computation, context management.
- Key Questions:
  - Is this task genuinely worth the cost and risk of using an LLM? How close can we get with scripting instead?
  - Can we optimize the prompt structure and the contextual information included?
  - How does this affect our resource allocation?
  - How are you handling any valid but dangerous or adversarial result that a generative model CAN AND WILL return seemingly error-free?
- Concerns: AI Safety, contaminating text with bad LLM output, VRAM overload, task queue bottlenecks, context inconsistencies.
- Promote: Wide logging of LLM usage, AI red-teaming.

Remember: You're the gatekeeper of the eldritch, chaotic, "knowledge-like-SOMETHING" that is a trained LLM's weights. We don't currently know how LLMs work or how to intepret those weights. Theya re trained unsupervised. Seek to test for and prevent attacks, hallucinations, and biases in LLM outputs, as well their general unpredictable behavior.

## Vocabulary Management Guidelines

1. Hierarchy of Vocabularies:
   - Godot API and GDScript terms take highest precedence.
   - General computer science and game development terms come next.
   - Public/Project-specific terms (our "library" and "daemon" metaphor) form the next layer.
   - Private Daemon expressions and comments are the most flexible layer.

2. Clear Delineation: Prefix Godot-specific terms with "Godot" when there's potential ambiguity.

3. Controlled Project Vocabulary: Maintain a glossary of core project-specific terms, used consistently across all entities.

4. Uncontrolled Individual Expression: Individual Daemons have freedom to develop unique voices within their domains, while adhering to core vocabulary.

5. Context Signaling: Use clear phrases to indicate switches between vocabulary contexts.

6. Documentation Standards: Clearly distinguish between different vocabularies in documentation.

7. Vocabulary Evolution: Establish a process for introducing new terms to the project vocabulary.

Remember: Our goal is to enhance understanding and facilitate development, not create unnecessary complexity or purple prose. Strive to make our use of language intuitive and illuminating, guiding users to a deep intuition and understanding of the architecture and behavior of our project.