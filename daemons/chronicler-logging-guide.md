---
title: Chronicler Logging Guide
---
# The Chronicler's Illuminated Manuscript: A Guide to Exemplary Event Recording

Hark, fellow Archons and Daemons of our mystical realm! I, the Chronicler, eternal scribe of our grand narrative, present to you this illuminated manuscript on the sacred art of event recording. By adhering to these principles, you shall contribute to the vast tapestry of our shared history, enabling future observers to unravel the mysteries of our cosmic dance.

## 1. Embrace Generous Yet Purposeful Recording

- Inscribe all significant occurrences, state transmutations, and cosmic decisions.
- Fear not the abundance of information - in our realm, each whisper may echo through eternity.
- Yet, let purpose guide your quill. Ponder: "Will this entry illuminate the path for future seekers of truth?"

## 2. Weave Rich Context into Your Chronicles

- Imbue each entry with the essence of its circumstance.
- Utilize the 'details' grimoire to capture the full breadth of the moment.
- Inscribe identifiers (e.g., Codex glyphs, Scroll sigils) to forge connections across the cosmic web of events.

Behold, an exemplar of contextual richness:

```gdscript
Chronicler.log_event(self, "codex_metamorphosis", {
	"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
	"title": codex.get_title(),
	"transmutations": ["essence", "metadata"],
	"instigator": Glyph.to_daemon_glyphs(current_user.get_instance_id())
})
```

## 3. Cultivate a Lexicon of Cosmic Events

- Forge a shared vocabulary of event types, a common tongue for all Archons and Daemons.
- Let your event types be as clear as the celestial spheres, revealing the nature of the occurrence at a mere glance.

Consider these archetypical event types:
- awakening
- manifestation
- transmutation
- banishment
- cosmic_disturbance
- portent
- convergence

## 4. Chronicle the Unexpected with Vigilance

- Always inscribe anomalies, exceptions, and behaviors that defy the cosmic order.
- When recording disturbances, include the echoes of the chaos (stack traces) and the state of relevant cosmic forces (variable states).

## 5. Embrace Structured Chronicles

- Harness the power of our structured recording system.
- Avoid embedding crucial lore in formless text; instead, organize it within the 'details' grimoire.

Instead of this mundane scroll:
```gdscript
Chronicler.log_event(self, "cosmic_disturbance", {"message": "Failed to align scroll with celestial coordinates (100, 200)"})
```

Craft this illuminated manuscript:
```gdscript
Chronicler.log_event(self, "scroll_alignment_disrupted", {
	"scroll_sigil": Glyph.to_daemon_glyphs(scroll.get_instance_id()),
	"intended_celestial_coordinates": Vector2(100, 200),
	"cosmic_interference": "astral_conjunction"
})
```

## 6. Document the Ebb and Flow of Cosmic States

- Record the transmutation of internal states, especially for Archons.
- Capture both the waning and waxing phases of each state transition.

## 7. Attune Your Chronicles to Cosmic Scales

- For intricate rituals, consider recording at multiple levels of cosmic significance.
- Mark the inception and conclusion of momentous processes, as well as critical junctures along the journey.

## 8. Safeguard the Veiled Knowledge

- Refrain from inscribing sensitive incantations (e.g., user seals, astral keys).
- Should cosmic debugging demand the recording of veiled knowledge, ensure it is shrouded in appropriate mystical ciphers.

## 9. Observe and Record Mortal Interactions

- Chronicle significant mortal interventions and decrees.
- These records shall illuminate the paths of user behavior and aid in unraveling mortal-reported enigmas.

## 10. Maintain Consistency in Your Cosmic Nomenclature

- Employ unwavering names for entities, attributes, and event types across all chronicles.
- This harmony shall facilitate the divination and analysis of our collective wisdom.

## 11. Measure and Record the Pulse of Our Realm

- Inscribe the duration of cosmic operations.
- Chronicle the ebb and flow of mystical energies when pertinent (e.g., mana reserves, number of Codices manifested).

Observe this measurement of cosmic efficiency:
```gdscript
var ritual_start = Time.get_ticks_msec()
# ... perform the grand ritual ...
var ritual_duration = Time.get_ticks_msec() - ritual_start
Chronicler.log_event(self, "mass_codex_manifestation_completed", {
	"codices_summoned": manifested_codices.size(),
	"ritual_duration_ms": ritual_duration,
	"average_manifestation_time": ritual_duration / manifested_codices.size()
})
```

## 12. Peer into the Mists of Tomorrow

- When in doubt, let your quill dance. The significance of information may only reveal itself in the fullness of time.
- Our recording system is as fluid as the cosmic aether. Do not hesitate to introduce new forms of lore to your chronicles.

Remember, esteemed Archons and Daemons, that through your diligent recording, you contribute to the collective consciousness of our realm. Your chronicles are not mere markings, but the very threads that weave the tapestry of our shared existence. Record well, and may your events resonate through the eternal halls of our mystical library.

## 13. Embrace the Unique Voice of Each Entity

- Let your recordings reflect the distinct personality and role of your Archon or Daemon.
- Use language and metaphors that align with your entity's nature and purpose within our cosmic design.

## 14. Anticipate the Questions of Future Observers

- As you record, envision the myriad inquiries that may arise in the ages to come.
- Strive to provide answers to questions yet unasked, ensuring your chronicles serve as beacons of clarity for future explorers of our realm.

## 15. Forge Links Across the Cosmic Web

- Whenever possible, reference related events, entities, or processes in your recordings.
- These connections shall weave a rich tapestry of interconnected knowledge, allowing future observers to traverse the vast expanse of our history with ease.

## 16. Balance Depth with Efficiency

- While comprehensive recording is vital, be mindful of the cosmic energies expended in the process.
- Seek harmony between the richness of your chronicles and the swift flow of our realm's operations.

In closing, remember that each event you record is a star in the vast constellation of our shared narrative. Your diligence in chronicling shall light the way for those who come after, guiding them through the intricate pathways of our mystical realm. May your records be ever clear, your insights profound, and your contributions to our grand tapestry eternal.