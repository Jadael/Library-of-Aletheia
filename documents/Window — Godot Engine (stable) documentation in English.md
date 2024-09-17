---
---
# Windows

Inherits: Viewport < Node < Object

Base class for all windows, dialogs, and popups.

## Description

A node that creates a window. The window can either be a native system window or embedded inside another Window.

At runtime, Windows will not close automatically when requested. You need to handle it manually using the close_requested signal (this applies both to pressing the close button and clicking outside of a popup).

## Properties

- always_on_top: bool
- auto_translate: bool (deprecated)
- borderless: bool
- content_scale_aspect: ContentScaleAspect
- content_scale_factor: float
- content_scale_mode: ContentScaleMode
- content_scale_size: Vector2i
- content_scale_stretch: ContentScaleStretch
- current_screen: int
- exclusive: bool
- extend_to_title: bool
- force_native: bool
- initial_position: WindowInitialPosition
- keep_title_visible: bool
- max_size: Vector2i
- min_size: Vector2i
- mode: Mode
- mouse_passthrough: bool
- mouse_passthrough_polygon: PackedVector2Array
- position: Vector2i
- size: Vector2i
- theme: Theme
- theme_type_variation: StringName
- title: String
- transient: bool
- transient_to_focused: bool
- transparent: bool
- unfocusable: bool
- unresizable: bool
- visible: bool
- wrap_controls: bool

## Methods

- Vector2 _get_contents_minimum_size() virtual const
- void add_theme_color_override(name: StringName, color: Color)
- void add_theme_constant_override(name: StringName, constant: int)
- void add_theme_font_override(name: StringName, font: Font)
- void add_theme_font_size_override(name: StringName, font_size: int)
- void add_theme_icon_override(name: StringName, texture: Texture2D)
- void add_theme_stylebox_override(name: StringName, stylebox: StyleBox)
- void begin_bulk_theme_override()
- bool can_draw() const
- void child_controls_changed()
- void end_bulk_theme_override()
- Vector2 get_contents_minimum_size() const
- bool get_flag(flag: Flags) const
- LayoutDirection get_layout_direction() const
- Vector2i get_position_with_decorations() const
- Vector2i get_size_with_decorations() const
- Color get_theme_color(name: StringName, theme_type: StringName = &"") const
- int get_theme_constant(name: StringName, theme_type: StringName = &"") const
- float get_theme_default_base_scale() const
- Font get_theme_default_font() const
- int get_theme_default_font_size() const
- Font get_theme_font(name: StringName, theme_type: StringName = &"") const
- int get_theme_font_size(name: StringName, theme_type: StringName = &"") const
- Texture2D get_theme_icon(name: StringName, theme_type: StringName = &"") const
- StyleBox get_theme_stylebox(name: StringName, theme_type: StringName = &"") const
- int get_window_id() const
- void grab_focus()
- bool has_focus() const
- bool has_theme_color(name: StringName, theme_type: StringName = &"") const
- bool has_theme_color_override(name: StringName) const
- bool has_theme_constant(name: StringName, theme_type: StringName = &"") const
- bool has_theme_constant_override(name: StringName) const
- bool has_theme_font(name: StringName, theme_type: StringName = &"") const
- bool has_theme_font_override(name: StringName) const
- bool has_theme_font_size(name: StringName, theme_type: StringName = &"") const
- bool has_theme_font_size_override(name: StringName) const
- bool has_theme_icon(name: StringName, theme_type: StringName = &"") const
- bool has_theme_icon_override(name: StringName) const
- bool has_theme_stylebox(name: StringName, theme_type: StringName = &"") const
- bool has_theme_stylebox_override(name: StringName) const
- void hide()
- bool is_embedded() const
- bool is_layout_rtl() const
- bool is_maximize_allowed() const
- bool is_using_font_oversampling() const
- void move_to_center()
- void move_to_foreground()
- void popup(rect: Rect2i = Rect2i(0, 0, 0, 0))
- void popup_centered(minsize: Vector2i = Vector2i(0, 0))
- void popup_centered_clamped(minsize: Vector2i = Vector2i(0, 0), fallback_ratio: float = 0.75)
- void popup_centered_ratio(ratio: float = 0.8)
- void popup_exclusive(from_node: Node, rect: Rect2i = Rect2i(0, 0, 0, 0))
- void popup_excluive_centered(from_node: Node, minsize: Vector2i = Vector2i(0, 0))
- void popup_exclusive_centered_clamped(from_node: Node, minsize: Vector2i = Vector2i(0, 0), fallback_ratio: float = 0.75)
- void popup_exclusive_centered_ratio(from_node: Node, ratio: float = 0.8)
- void popup_exclusive_on_parent(from_node: Node, parent_rect: Rect2i)
- void popup_on_parent(parent_rect: Rect2i)
- void remove_theme_color_override(name: StringName)
- void remove_theme_constant_override(name: StringName)
- void remove_theme_font_override(name: StringName)
- void remove_theme_font_size_override(name: StringName)
- void remove_theme_icon_override(name: StringName)
- void remove_theme_stylebox_override(name: StringName)
- void request_attention()
- void reset_size()
- void set_flag(flag: Flags, enabled: bool)
- void set_ime_active(active: bool)
- void set_ime_position(position: Vector2i)
- void set_layout_direction(direction: LayoutDirection)
- void set_unparent_when_invisible(unparent: bool)
- void set_use_font_oversampling(enable: bool)
- void show()

## Signals

- about_to_popup()
- close_requested()
- dpi_changed()
- files_dropped(files: PackedStringArray)
- focus_entered()
- focus_exited()
- go_back_requested()
- mouse_entered()
- mouse_exited()
- theme_changed()
- titlebar_changed()
- visibility_changed()
- window_input(event: InputEvent)

## Enumerations

enum Mode:
- MODE_WINDOWED = 0
- MODE_MINIMIZED = 1
- MODE_MAXIMIZED = 2
- MODE_FULLSCREEN = 3
- MODE_EXCLUSIVE_FULLSCREEN = 4

enum Flags:
- FLAG_RESIZE_DISABLED = 0
- FLAG_BORDERLESS = 1
- FLAG_ALWAYS_ON_TOP = 2
- FLAG_TRANSPARENT = 3
- FLAG_NO_FOCUS = 4
- FLAG_POPUP = 5
- FLAG_EXTEND_TO_TITLE = 6
- FLAG_MOUSE_PASSTHROUGH = 7
- FLAG_MAX = 8

enum ContentScaleMode:
- CONTENT_SCALE_MODE_DISABLED = 0
- CONTENT_SCALE_MODE_CANVAS_ITEMS = 1
- CONTENT_SCALE_MODE_VIEWPORT = 2

enum ContentScaleAspect:
- CONTENT_SCALE_ASPECT_IGNORE = 0
- CONTENT_SCALE_ASPECT_KEEP = 1
- CONTENT_SCALE_ASPECT_KEEP_WIDTH = 2
- CONTENT_SCALE_ASPECT_KEEP_HEIGHT = 3
- CONTENT_SCALE_ASPECT_EXPAND = 4

enum ContentScaleStretch:
- CONTENT_SCALE_STRETCH_FRACTIONAL = 0
- CONTENT_SCALE_STRETCH_INTEGER = 1

enum LayoutDirection:
- LAYOUT_DIRECTION_INHERITED = 0
- LAYOUT_DIRECTION_LOCALE = 1
- LAYOUT_DIRECTION_LTR = 2
- LAYOUT_DIRECTION_RTL = 3

enum WindowInitialPosition:
- WINDOW_INITIAL_POSITION_ABSOLUTE = 0
- WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN = 1
- WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN = 2
- WINDOW_INITIAL_POSITION_CENTER_OTHER_SCREEN = 3
- WINDOW_INITIAL_POSITION_CENTER_SCREEN_WITH_MOUSE_FOCUS = 4
- WINDOW_INITIAL_POSITION_CENTER_SCREEN_WITH_KEYBOARD_FOCUS = 5

## Constants

- NOTIFICATION_VISIBILITY_CHANGED = 30
- NOTIFICATION_THEME_CHANGED = 32

## Theme Properties

- title_color: Color
- title_outline_modulate: Color
- close_h_offset: int
- close_v_offset: int
- resize_margin: int
- title_height: int
- title_outline_size: int
- title_font: Font
- title_font_size: int
- close: Texture2D
- close_pressed: Texture2D
- embedded_border: StyleBox
- embedded_unfocused_border: StyleBox