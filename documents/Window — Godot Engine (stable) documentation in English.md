**Inherits:** [Viewport](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport) **<** [Node](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node) **<** [Object](https://docs.godotengine.org/en/stable/classes/class_object.html#class-object)

**Inherited By:** [AcceptDialog](https://docs.godotengine.org/en/stable/classes/class_acceptdialog.html#class-acceptdialog), [Popup](https://docs.godotengine.org/en/stable/classes/class_popup.html#class-popup)

Base class for all windows, dialogs, and popups.

## Description[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#description "Permalink to this headline")

A node that creates a window. The window can either be a native system window or embedded inside another **Window** (see [Viewport.gui\_embed\_subwindows](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport-property-gui-embed-subwindows)).

At runtime, **Window**s will not close automatically when requested. You need to handle it manually using the [close\_requested](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-signal-close-requested) signal (this applies both to pressing the close button and clicking outside of a popup).

## Properties[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#properties "Permalink to this headline")

## Methods[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#methods "Permalink to this headline")

<table><tbody><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_vector2.html#class-vector2"><span>Vector2</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-private-method-get-contents-minimum-size"><span>_get_contents_minimum_size</span></a>() <abbr title="This method should typically be overridden by the user to have any effect.">virtual</abbr> <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-color-override"><span>add_theme_color_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, color: <a href="https://docs.godotengine.org/en/stable/classes/class_color.html#class-color"><span>Color</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-constant-override"><span>add_theme_constant_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, constant: <a href="https://docs.godotengine.org/en/stable/classes/class_int.html#class-int"><span>int</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-font-override"><span>add_theme_font_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, font: <a href="https://docs.godotengine.org/en/stable/classes/class_font.html#class-font"><span>Font</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-font-size-override"><span>add_theme_font_size_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, font_size: <a href="https://docs.godotengine.org/en/stable/classes/class_int.html#class-int"><span>int</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-icon-override"><span>add_theme_icon_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, texture: <a href="https://docs.godotengine.org/en/stable/classes/class_texture2d.html#class-texture2d"><span>Texture2D</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-stylebox-override"><span>add_theme_stylebox_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, stylebox: <a href="https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox"><span>StyleBox</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-begin-bulk-theme-override"><span>begin_bulk_theme_override</span></a>()</p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-can-draw"><span>can_draw</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-child-controls-changed"><span>child_controls_changed</span></a>()</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-end-bulk-theme-override"><span>end_bulk_theme_override</span></a>()</p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_vector2.html#class-vector2"><span>Vector2</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-contents-minimum-size"><span>get_contents_minimum_size</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-flag"><span>get_flag</span></a>(flag: <a href="https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags"><span>Flags</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection"><span>LayoutDirection</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-layout-direction"><span>get_layout_direction</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-position-with-decorations"><span>get_position_with_decorations</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-size-with-decorations"><span>get_size_with_decorations</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_color.html#class-color"><span>Color</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-color"><span>get_theme_color</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_int.html#class-int"><span>int</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-constant"><span>get_theme_constant</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_float.html#class-float"><span>float</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-default-base-scale"><span>get_theme_default_base_scale</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_font.html#class-font"><span>Font</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-default-font"><span>get_theme_default_font</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_int.html#class-int"><span>int</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-default-font-size"><span>get_theme_default_font_size</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_font.html#class-font"><span>Font</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-font"><span>get_theme_font</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_int.html#class-int"><span>int</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-font-size"><span>get_theme_font_size</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_texture2d.html#class-texture2d"><span>Texture2D</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-icon"><span>get_theme_icon</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox"><span>StyleBox</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-stylebox"><span>get_theme_stylebox</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_int.html#class-int"><span>int</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-window-id"><span>get_window_id</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-grab-focus"><span>grab_focus</span></a>()</p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-focus"><span>has_focus</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-color"><span>has_theme_color</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-color-override"><span>has_theme_color_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-constant"><span>has_theme_constant</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-constant-override"><span>has_theme_constant_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-font"><span>has_theme_font</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-font-override"><span>has_theme_font_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-font-size"><span>has_theme_font_size</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-font-size-override"><span>has_theme_font_size_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-icon"><span>has_theme_icon</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-icon-override"><span>has_theme_icon_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-stylebox"><span>has_theme_stylebox</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>, theme_type: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a> = &amp;"") <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-has-theme-stylebox-override"><span>has_theme_stylebox_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>) <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-hide"><span>hide</span></a>()</p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-is-embedded"><span>is_embedded</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-is-layout-rtl"><span>is_layout_rtl</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-is-maximize-allowed"><span>is_maximize_allowed</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-is-using-font-oversampling"><span>is_using_font_oversampling</span></a>() <abbr title="This method has no side effects. It doesn't modify any of the instance's member variables.">const</abbr></p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-move-to-center"><span>move_to_center</span></a>()</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-move-to-foreground"><span>move_to_foreground</span></a>()</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup"><span>popup</span></a>(rect: <a href="https://docs.godotengine.org/en/stable/classes/class_rect2i.html#class-rect2i"><span>Rect2i</span></a> = Rect2i(0, 0, 0, 0))</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-centered"><span>popup_centered</span></a>(minsize: <a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a> = Vector2i(0, 0))</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-centered-clamped"><span>popup_centered_clamped</span></a>(minsize: <a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a> = Vector2i(0, 0), fallback_ratio: <a href="https://docs.godotengine.org/en/stable/classes/class_float.html#class-float"><span>float</span></a> = 0.75)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-centered-ratio"><span>popup_centered_ratio</span></a>(ratio: <a href="https://docs.godotengine.org/en/stable/classes/class_float.html#class-float"><span>float</span></a> = 0.8)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-exclusive"><span>popup_exclusive</span></a>(from_node: <a href="https://docs.godotengine.org/en/stable/classes/class_node.html#class-node"><span>Node</span></a>, rect: <a href="https://docs.godotengine.org/en/stable/classes/class_rect2i.html#class-rect2i"><span>Rect2i</span></a> = Rect2i(0, 0, 0, 0))</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-exclusive-centered"><span>popup_exclusive_centered</span></a>(from_node: <a href="https://docs.godotengine.org/en/stable/classes/class_node.html#class-node"><span>Node</span></a>, minsize: <a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a> = Vector2i(0, 0))</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-exclusive-centered-clamped"><span>popup_exclusive_centered_clamped</span></a>(from_node: <a href="https://docs.godotengine.org/en/stable/classes/class_node.html#class-node"><span>Node</span></a>, minsize: <a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a> = Vector2i(0, 0), fallback_ratio: <a href="https://docs.godotengine.org/en/stable/classes/class_float.html#class-float"><span>float</span></a> = 0.75)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-exclusive-centered-ratio"><span>popup_exclusive_centered_ratio</span></a>(from_node: <a href="https://docs.godotengine.org/en/stable/classes/class_node.html#class-node"><span>Node</span></a>, ratio: <a href="https://docs.godotengine.org/en/stable/classes/class_float.html#class-float"><span>float</span></a> = 0.8)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-exclusive-on-parent"><span>popup_exclusive_on_parent</span></a>(from_node: <a href="https://docs.godotengine.org/en/stable/classes/class_node.html#class-node"><span>Node</span></a>, parent_rect: <a href="https://docs.godotengine.org/en/stable/classes/class_rect2i.html#class-rect2i"><span>Rect2i</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-on-parent"><span>popup_on_parent</span></a>(parent_rect: <a href="https://docs.godotengine.org/en/stable/classes/class_rect2i.html#class-rect2i"><span>Rect2i</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-color-override"><span>remove_theme_color_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-constant-override"><span>remove_theme_constant_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-font-override"><span>remove_theme_font_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-font-size-override"><span>remove_theme_font_size_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-icon-override"><span>remove_theme_icon_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-stylebox-override"><span>remove_theme_stylebox_override</span></a>(name: <a href="https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname"><span>StringName</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-request-attention"><span>request_attention</span></a>()</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-reset-size"><span>reset_size</span></a>()</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-flag"><span>set_flag</span></a>(flag: <a href="https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags"><span>Flags</span></a>, enabled: <a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-ime-active"><span>set_ime_active</span></a>(active: <a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-ime-position"><span>set_ime_position</span></a>(position: <a href="https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i"><span>Vector2i</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-layout-direction"><span>set_layout_direction</span></a>(direction: <a href="https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection"><span>LayoutDirection</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-unparent-when-invisible"><span>set_unparent_when_invisible</span></a>(unparent: <a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-use-font-oversampling"><span>set_use_font_oversampling</span></a>(enable: <a href="https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool"><span>bool</span></a>)</p></td></tr><tr><td><p><abbr title="No return value.">void</abbr></p></td><td><p><a href="https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-show"><span>show</span></a>()</p></td></tr></tbody></table>

## Theme Properties[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#theme-properties "Permalink to this headline")

___

## Signals[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#signals "Permalink to this headline")

Emitted right after [popup](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup) call, before the **Window** appears or does anything.

___

**close\_requested**()

Emitted when the **Window**'s close button is pressed or when [popup\_window](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-popup-window) is enabled and user clicks outside the window.

This signal can be used to handle window closing, e.g. by connecting it to [hide](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-hide).

___

**dpi\_changed**()

Emitted when the **Window**'s DPI changes as a result of OS-level changes (e.g. moving the window from a Retina display to a lower resolution one).

**Note:** Only implemented on macOS.

___

**files\_dropped**(files: [PackedStringArray](https://docs.godotengine.org/en/stable/classes/class_packedstringarray.html#class-packedstringarray))

Emitted when files are dragged from the OS file manager and dropped in the game window. The argument is a list of file paths.

Note that this method only works with native windows, i.e. the main window and **Window**\-derived nodes when [Viewport.gui\_embed\_subwindows](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport-property-gui-embed-subwindows) is disabled in the main viewport.

Example usage:

```
<span></span><span>func</span><span> </span><span>_ready</span><span>():</span>
<span>get_viewport</span><span>()</span><span>.</span><span>files_dropped</span><span>.</span><span>connect</span><span>(</span><span>on_files_dropped</span><span>)</span>

<span>func</span><span> </span><span>on_files_dropped</span><span>(</span><span>files</span><span>):</span>
<span>print</span><span>(</span><span>files</span><span>)</span>
```

___

**focus\_entered**()

Emitted when the **Window** gains focus.

___

**focus\_exited**()

Emitted when the **Window** loses its focus.

___

**go\_back\_requested**()

Emitted when a go back request is sent (e.g. pressing the "Back" button on Android), right after [Node.NOTIFICATION\_WM\_GO\_BACK\_REQUEST](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-constant-notification-wm-go-back-request).

___

**mouse\_entered**()

Emitted when the mouse cursor enters the **Window**'s visible area, that is not occluded behind other [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control)s or windows, provided its [Viewport.gui\_disable\_input](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport-property-gui-disable-input) is `false` and regardless if it's currently focused or not.

___

**mouse\_exited**()

Emitted when the mouse cursor leaves the **Window**'s visible area, that is not occluded behind other [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control)s or windows, provided its [Viewport.gui\_disable\_input](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport-property-gui-disable-input) is `false` and regardless if it's currently focused or not.

___

**theme\_changed**()

Emitted when the [NOTIFICATION\_THEME\_CHANGED](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-constant-notification-theme-changed) notification is sent.

___

**titlebar\_changed**()

Emitted when window title bar decorations are changed, e.g. macOS window enter/exit full screen mode, or extend-to-title flag is changed.

___

**visibility\_changed**()

Emitted when **Window** is made visible or disappears.

___

**window\_input**(event: [InputEvent](https://docs.godotengine.org/en/stable/classes/class_inputevent.html#class-inputevent))

Emitted when the **Window** is currently focused and receives any input, passing the received event as an argument. The event's position, if present, is in the embedder's coordinate system.

___

## Enumerations[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#enumerations "Permalink to this headline")

enum **Mode**:

[Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **MODE\_WINDOWED** = `0`

Windowed mode, i.e. **Window** doesn't occupy the whole screen (unless set to the size of the screen).

[Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **MODE\_MINIMIZED** = `1`

Minimized window mode, i.e. **Window** is not visible and available on window manager's window list. Normally happens when the minimize button is pressed.

[Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **MODE\_MAXIMIZED** = `2`

Maximized window mode, i.e. **Window** will occupy whole screen area except task bar and still display its borders. Normally happens when the maximize button is pressed.

[Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **MODE\_FULLSCREEN** = `3`

Full screen mode with full multi-window support.

Full screen window covers the entire display area of a screen and has no decorations. The display's video mode is not changed.

**On Windows:** Multi-window full-screen mode has a 1px border of the [ProjectSettings.rendering/environment/defaults/default\_clear\_color](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-rendering-environment-defaults-default-clear-color) color.

**On macOS:** A new desktop is used to display the running project.

**Note:** Regardless of the platform, enabling full screen will change the window size to match the monitor's size. Therefore, make sure your project supports [multiple resolutions](https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html) when enabling full screen mode.

[Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **MODE\_EXCLUSIVE\_FULLSCREEN** = `4`

A single window full screen mode. This mode has less overhead, but only one window can be open on a given screen at a time (opening a child window or application switching will trigger a full screen transition).

Full screen window covers the entire display area of a screen and has no border or decorations. The display's video mode is not changed.

**On Windows:** Depending on video driver, full screen transition might cause screens to go black for a moment.

**On macOS:** A new desktop is used to display the running project. Exclusive full screen mode prevents Dock and Menu from showing up when the mouse pointer is hovering the edge of the screen.

**On Linux (X11):** Exclusive full screen mode bypasses compositor.

**Note:** Regardless of the platform, enabling full screen will change the window size to match the monitor's size. Therefore, make sure your project supports [multiple resolutions](https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html) when enabling full screen mode.

___

enum **Flags**:

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_RESIZE\_DISABLED** = `0`

The window can't be resized by dragging its resize grip. It's still possible to resize the window using [size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-size). This flag is ignored for full screen windows. Set with [unresizable](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-unresizable).

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_BORDERLESS** = `1`

The window do not have native title bar and other decorations. This flag is ignored for full-screen windows. Set with [borderless](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-borderless).

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_ALWAYS\_ON\_TOP** = `2`

The window is floating on top of all other windows. This flag is ignored for full-screen windows. Set with [always\_on\_top](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-always-on-top).

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_TRANSPARENT** = `3`

The window background can be transparent. Set with [transparent](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transparent).

**Note:** This flag has no effect if either [ProjectSettings.display/window/per\_pixel\_transparency/allowed](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-display-window-per-pixel-transparency-allowed), or the window's [Viewport.transparent\_bg](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport-property-transparent-bg) is set to `false`.

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_NO\_FOCUS** = `4`

The window can't be focused. No-focus window will ignore all input, except mouse clicks. Set with [unfocusable](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-unfocusable).

Window is part of menu or [OptionButton](https://docs.godotengine.org/en/stable/classes/class_optionbutton.html#class-optionbutton) dropdown. This flag can't be changed when the window is visible. An active popup window will exclusively receive all input, without stealing focus from its parent. Popup windows are automatically closed when uses click outside it, or when an application is switched. Popup window must have transient parent set (see [transient](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transient)).

**Note:** This flag has no effect in embedded windows (unless said window is a [Popup](https://docs.godotengine.org/en/stable/classes/class_popup.html#class-popup)).

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_EXTEND\_TO\_TITLE** = `6`

Window content is expanded to the full size of the window. Unlike borderless window, the frame is left intact and can be used to resize the window, title bar is transparent, but have minimize/maximize/close buttons. Set with [extend\_to\_title](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-extend-to-title).

**Note:** This flag is implemented only on macOS.

**Note:** This flag has no effect in embedded windows.

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_MOUSE\_PASSTHROUGH** = `7`

All mouse events are passed to the underlying window of the same application.

**Note:** This flag has no effect in embedded windows.

[Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags) **FLAG\_MAX** = `8`

Max value of the [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags).

___

enum **ContentScaleMode**:

[ContentScaleMode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalemode) **CONTENT\_SCALE\_MODE\_DISABLED** = `0`

The content will not be scaled to match the **Window**'s size.

[ContentScaleMode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalemode) **CONTENT\_SCALE\_MODE\_CANVAS\_ITEMS** = `1`

The content will be rendered at the target size. This is more performance-expensive than [CONTENT\_SCALE\_MODE\_VIEWPORT](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-constant-content-scale-mode-viewport), but provides better results.

[ContentScaleMode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalemode) **CONTENT\_SCALE\_MODE\_VIEWPORT** = `2`

The content will be rendered at the base size and then scaled to the target size. More performant than [CONTENT\_SCALE\_MODE\_CANVAS\_ITEMS](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-constant-content-scale-mode-canvas-items), but results in pixelated image.

___

enum **ContentScaleAspect**:

[ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **CONTENT\_SCALE\_ASPECT\_IGNORE** = `0`

The aspect will be ignored. Scaling will simply stretch the content to fit the target size.

[ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **CONTENT\_SCALE\_ASPECT\_KEEP** = `1`

The content's aspect will be preserved. If the target size has different aspect from the base one, the image will be centered and black bars will appear on left and right sides.

[ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **CONTENT\_SCALE\_ASPECT\_KEEP\_WIDTH** = `2`

The content can be expanded vertically. Scaling horizontally will result in keeping the width ratio and then black bars on left and right sides.

[ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **CONTENT\_SCALE\_ASPECT\_KEEP\_HEIGHT** = `3`

The content can be expanded horizontally. Scaling vertically will result in keeping the height ratio and then black bars on top and bottom sides.

[ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **CONTENT\_SCALE\_ASPECT\_EXPAND** = `4`

The content's aspect will be preserved. If the target size has different aspect from the base one, the content will stay in the top-left corner and add an extra visible area in the stretched space.

___

enum **ContentScaleStretch**:

[ContentScaleStretch](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalestretch) **CONTENT\_SCALE\_STRETCH\_FRACTIONAL** = `0`

The content will be stretched according to a fractional factor. This fills all the space available in the window, but allows "pixel wobble" to occur due to uneven pixel scaling.

[ContentScaleStretch](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalestretch) **CONTENT\_SCALE\_STRETCH\_INTEGER** = `1`

The content will be stretched only according to an integer factor, preserving sharp pixels. This may leave a black background visible on the window's edges depending on the window size.

___

enum **LayoutDirection**:

[LayoutDirection](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection) **LAYOUT\_DIRECTION\_INHERITED** = `0`

Automatic layout direction, determined from the parent window layout direction.

[LayoutDirection](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection) **LAYOUT\_DIRECTION\_LOCALE** = `1`

Automatic layout direction, determined from the current locale.

[LayoutDirection](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection) **LAYOUT\_DIRECTION\_LTR** = `2`

Left-to-right layout direction.

[LayoutDirection](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection) **LAYOUT\_DIRECTION\_RTL** = `3`

Right-to-left layout direction.

___

enum **WindowInitialPosition**:

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **WINDOW\_INITIAL\_POSITION\_ABSOLUTE** = `0`

Initial window position is determined by [position](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-position).

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **WINDOW\_INITIAL\_POSITION\_CENTER\_PRIMARY\_SCREEN** = `1`

Initial window position is the center of the primary screen.

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **WINDOW\_INITIAL\_POSITION\_CENTER\_MAIN\_WINDOW\_SCREEN** = `2`

Initial window position is the center of the main window screen.

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **WINDOW\_INITIAL\_POSITION\_CENTER\_OTHER\_SCREEN** = `3`

Initial window position is the center of [current\_screen](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-current-screen) screen.

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **WINDOW\_INITIAL\_POSITION\_CENTER\_SCREEN\_WITH\_MOUSE\_FOCUS** = `4`

Initial window position is the center of the screen containing the mouse pointer.

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **WINDOW\_INITIAL\_POSITION\_CENTER\_SCREEN\_WITH\_KEYBOARD\_FOCUS** = `5`

Initial window position is the center of the screen containing the window with the keyboard focus.

___

## Constants[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#constants "Permalink to this headline")

**NOTIFICATION\_VISIBILITY\_CHANGED** = `30`

Emitted when **Window**'s visibility changes, right before [visibility\_changed](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-signal-visibility-changed).

**NOTIFICATION\_THEME\_CHANGED** = `32`

Sent when the node needs to refresh its theme items. This happens in one of the following cases:

-   The [theme](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-theme) property is changed on this node or any of its ancestors.
    
-   The [theme\_type\_variation](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-theme-type-variation) property is changed on this node.
    
-   The node enters the scene tree.
    

**Note:** As an optimization, this notification won't be sent from changes that occur while this node is outside of the scene tree. Instead, all of the theme item updates can be applied at once when the node enters the scene tree.

___

## Property Descriptions[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#property-descriptions "Permalink to this headline")

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **always\_on\_top** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the window will be on top of all other windows. Does not work if [transient](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transient) is enabled.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **auto\_translate** = `true`

-   void **set\_auto\_translate**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_auto\_translating**()
    

**Deprecated:** Use [Node.auto\_translate\_mode](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-property-auto-translate-mode) instead.

Toggles if any text should automatically change to its translated version depending on the current locale.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **borderless** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the window will have no borders.

___

[ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **content\_scale\_aspect** = `0`

-   void **set\_content\_scale\_aspect**(value: [ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect))
    
-   [ContentScaleAspect](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscaleaspect) **get\_content\_scale\_aspect**()
    

Specifies how the content's aspect behaves when the **Window** is resized. The base aspect is determined by [content\_scale\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-content-scale-size).

___

[float](https://docs.godotengine.org/en/stable/classes/class_float.html#class-float) **content\_scale\_factor** = `1.0`

-   void **set\_content\_scale\_factor**(value: [float](https://docs.godotengine.org/en/stable/classes/class_float.html#class-float))
    
-   [float](https://docs.godotengine.org/en/stable/classes/class_float.html#class-float) **get\_content\_scale\_factor**()
    

Specifies the base scale of **Window**'s content when its [size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-size) is equal to [content\_scale\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-content-scale-size).

___

[ContentScaleMode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalemode) **content\_scale\_mode** = `0`

-   void **set\_content\_scale\_mode**(value: [ContentScaleMode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalemode))
    
-   [ContentScaleMode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalemode) **get\_content\_scale\_mode**()
    

Specifies how the content is scaled when the **Window** is resized.

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **content\_scale\_size** = `Vector2i(0, 0)`

-   void **set\_content\_scale\_size**(value: [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i))
    
-   [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_content\_scale\_size**()
    

Base size of the content (i.e. nodes that are drawn inside the window). If non-zero, **Window**'s content will be scaled when the window is resized to a different size.

___

[ContentScaleStretch](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalestretch) **content\_scale\_stretch** = `0`

-   void **set\_content\_scale\_stretch**(value: [ContentScaleStretch](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalestretch))
    
-   [ContentScaleStretch](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-contentscalestretch) **get\_content\_scale\_stretch**()
    

The policy to use to determine the final scale factor for 2D elements. This affects how [content\_scale\_factor](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-content-scale-factor) is applied, in addition to the automatic scale factor determined by [content\_scale\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-content-scale-size).

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **current\_screen**

-   void **set\_current\_screen**(value: [int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int))
    
-   [int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **get\_current\_screen**()
    

The screen the window is currently on.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **exclusive** = `false`

-   void **set\_exclusive**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_exclusive**()
    

If `true`, the **Window** will be in exclusive mode. Exclusive windows are always on top of their parent and will block all input going to the parent **Window**.

Needs [transient](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transient) enabled to work.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **extend\_to\_title** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the **Window** contents is expanded to the full size of the window, window title bar is transparent.

**Note:** This property is implemented only on macOS.

**Note:** This property only works with native windows.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **force\_native** = `false`

-   void **set\_force\_native**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_force\_native**()
    

If `true`, native window will be used regardless of parent viewport and project settings.

___

[WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **initial\_position** = `0`

-   void **set\_initial\_position**(value: [WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition))
    
-   [WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) **get\_initial\_position**()
    

Specifies the initial type of position for the **Window**. See [WindowInitialPosition](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-windowinitialposition) constants.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **keep\_title\_visible** = `false`

-   void **set\_keep\_title\_visible**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_keep\_title\_visible**()
    

If `true`, the **Window** width is expanded to keep the title bar text fully visible.

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **max\_size** = `Vector2i(0, 0)`

-   void **set\_max\_size**(value: [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i))
    
-   [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_max\_size**()
    

If non-zero, the **Window** can't be resized to be bigger than this size.

**Note:** This property will be ignored if the value is lower than [min\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-min-size).

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **min\_size** = `Vector2i(0, 0)`

-   void **set\_min\_size**(value: [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i))
    
-   [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_min\_size**()
    

If non-zero, the **Window** can't be resized to be smaller than this size.

**Note:** This property will be ignored in favor of [get\_contents\_minimum\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-contents-minimum-size) if [wrap\_controls](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-wrap-controls) is enabled and if its size is bigger.

___

[Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **mode** = `0`

-   void **set\_mode**(value: [Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode))
    
-   [Mode](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-mode) **get\_mode**()
    

Set's the window's current mode.

**Note:** Fullscreen mode is not exclusive full screen on Windows and Linux.

**Note:** This method only works with native windows, i.e. the main window and **Window**\-derived nodes when [Viewport.gui\_embed\_subwindows](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport-property-gui-embed-subwindows) is disabled in the main viewport.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **mouse\_passthrough** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, all mouse events will be passed to the underlying window of the same application. See also [mouse\_passthrough\_polygon](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-mouse-passthrough-polygon).

**Note:** This property is implemented on Linux (X11), macOS and Windows.

**Note:** This property only works with native windows.

___

[PackedVector2Array](https://docs.godotengine.org/en/stable/classes/class_packedvector2array.html#class-packedvector2array) **mouse\_passthrough\_polygon** = `PackedVector2Array()`

-   void **set\_mouse\_passthrough\_polygon**(value: [PackedVector2Array](https://docs.godotengine.org/en/stable/classes/class_packedvector2array.html#class-packedvector2array))
    
-   [PackedVector2Array](https://docs.godotengine.org/en/stable/classes/class_packedvector2array.html#class-packedvector2array) **get\_mouse\_passthrough\_polygon**()
    

Sets a polygonal region of the window which accepts mouse events. Mouse events outside the region will be passed through.

Passing an empty array will disable passthrough support (all mouse events will be intercepted by the window, which is the default behavior).

```
<span></span><span># Set region, using Path2D node.</span>
<span>$</span><span>Window</span><span>.</span><span>mouse_passthrough_polygon</span><span> </span><span>=</span><span> </span><span>$</span><span>Path2D</span><span>.</span><span>curve</span><span>.</span><span>get_baked_points</span><span>()</span>

<span># Set region, using Polygon2D node.</span>
<span>$</span><span>Window</span><span>.</span><span>mouse_passthrough_polygon</span><span> </span><span>=</span><span> </span><span>$</span><span>Polygon2D</span><span>.</span><span>polygon</span>

<span># Reset region to default.</span>
<span>$</span><span>Window</span><span>.</span><span>mouse_passthrough_polygon</span><span> </span><span>=</span><span> </span><span>[]</span>
```

**Note:** This property is ignored if [mouse\_passthrough](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-mouse-passthrough) is set to `true`.

**Note:** On Windows, the portion of a window that lies outside the region is not drawn, while on Linux (X11) and macOS it is.

**Note:** This property is implemented on Linux (X11), macOS and Windows.

**Note:** The returned array is _copied_ and any changes to it will not update the original property value. See [PackedVector2Array](https://docs.godotengine.org/en/stable/classes/class_packedvector2array.html#class-packedvector2array) for more details.

___

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the **Window** will be considered a popup. Popups are sub-windows that don't show as separate windows in system's window manager's window list and will send close request when anything is clicked outside of them (unless [exclusive](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-exclusive) is enabled).

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **position** = `Vector2i(0, 0)`

-   void **set\_position**(value: [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i))
    
-   [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_position**()
    

The window's position in pixels.

If [ProjectSettings.display/window/subwindows/embed\_subwindows](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-display-window-subwindows-embed-subwindows) is `false`, the position is in absolute screen coordinates. This typically applies to editor plugins. If the setting is `true`, the window's position is in the coordinates of its parent [Viewport](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport).

**Note:** This property only works if [initial\_position](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-initial-position) is set to [WINDOW\_INITIAL\_POSITION\_ABSOLUTE](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-constant-window-initial-position-absolute).

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **size** = `Vector2i(100, 100)`

-   void **set\_size**(value: [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i))
    
-   [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_size**()
    

The window's size in pixels.

___

[Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) **theme**

-   void **set\_theme**(value: [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme))
    
-   [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) **get\_theme**()
    

The [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) resource this node and all its [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) and **Window** children use. If a child node has its own [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) resource set, theme items are merged with child's definitions having higher priority.

**Note:** **Window** styles will have no effect unless the window is embedded.

___

[StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) **theme\_type\_variation** = `&""`

-   void **set\_theme\_type\_variation**(value: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))
    
-   [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) **get\_theme\_type\_variation**()
    

The name of a theme type variation used by this **Window** to look up its own theme items. See [Control.theme\_type\_variation](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-property-theme-type-variation) for more details.

___

[String](https://docs.godotengine.org/en/stable/classes/class_string.html#class-string) **title** = `""`

-   void **set\_title**(value: [String](https://docs.godotengine.org/en/stable/classes/class_string.html#class-string))
    
-   [String](https://docs.godotengine.org/en/stable/classes/class_string.html#class-string) **get\_title**()
    

The window's title. If the **Window** is native, title styles set in [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) will have no effect.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **transient** = `false`

-   void **set\_transient**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_transient**()
    

If `true`, the **Window** is transient, i.e. it's considered a child of another **Window**. The transient window will be destroyed with its transient parent and will return focus to their parent when closed. The transient window is displayed on top of a non-exclusive full-screen parent window. Transient windows can't enter full-screen mode.

Note that behavior might be different depending on the platform.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **transient\_to\_focused** = `false`

-   void **set\_transient\_to\_focused**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_transient\_to\_focused**()
    

If `true`, and the **Window** is [transient](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transient), this window will (at the time of becoming visible) become transient to the currently focused window instead of the immediate parent window in the hierarchy. Note that the transient parent is assigned at the time this window becomes visible, so changing it afterwards has no effect until re-shown.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **transparent** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the **Window**'s background can be transparent. This is best used with embedded windows.

**Note:** Transparency support is implemented on Linux, macOS and Windows, but availability might vary depending on GPU driver, display manager, and compositor capabilities.

**Note:** This property has no effect if [ProjectSettings.display/window/per\_pixel\_transparency/allowed](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-display-window-per-pixel-transparency-allowed) is set to `false`.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **unfocusable** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the **Window** can't be focused nor interacted with. It can still be visible.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **unresizable** = `false`

-   void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const
    

If `true`, the window can't be resized. Minimize and maximize buttons are disabled.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **visible** = `true`

-   void **set\_visible**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_visible**()
    

If `true`, the window is visible.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **wrap\_controls** = `false`

-   void **set\_wrap\_controls**(value: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))
    
-   [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_wrapping\_controls**()
    

If `true`, the window's size will automatically update when a child node is added or removed, ignoring [min\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-min-size) if the new size is bigger.

If `false`, you need to call [child\_controls\_changed](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-child-controls-changed) manually.

___

## Method Descriptions[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#method-descriptions "Permalink to this headline")

[Vector2](https://docs.godotengine.org/en/stable/classes/class_vector2.html#class-vector2) **\_get\_contents\_minimum\_size**() virtual const

Virtual method to be implemented by the user. Overrides the value returned by [get\_contents\_minimum\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-contents-minimum-size).

___

void **add\_theme\_color\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), color: [Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color))

Creates a local override for a theme [Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) with the specified `name`. Local overrides always take precedence when fetching theme items for the control. An override can be removed with [remove\_theme\_color\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-color-override).

See also [get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-color) and [Control.add\_theme\_color\_override](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-add-theme-color-override) for more details.

___

void **add\_theme\_constant\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), constant: [int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int))

Creates a local override for a theme constant with the specified `name`. Local overrides always take precedence when fetching theme items for the control. An override can be removed with [remove\_theme\_constant\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-constant-override).

See also [get\_theme\_constant](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-constant).

___

void **add\_theme\_font\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), font: [Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font))

Creates a local override for a theme [Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) with the specified `name`. Local overrides always take precedence when fetching theme items for the control. An override can be removed with [remove\_theme\_font\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-font-override).

See also [get\_theme\_font](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-font).

___

void **add\_theme\_font\_size\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), font\_size: [int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int))

Creates a local override for a theme font size with the specified `name`. Local overrides always take precedence when fetching theme items for the control. An override can be removed with [remove\_theme\_font\_size\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-font-size-override).

See also [get\_theme\_font\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-font-size).

___

void **add\_theme\_icon\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), texture: [Texture2D](https://docs.godotengine.org/en/stable/classes/class_texture2d.html#class-texture2d))

Creates a local override for a theme icon with the specified `name`. Local overrides always take precedence when fetching theme items for the control. An override can be removed with [remove\_theme\_icon\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-icon-override).

See also [get\_theme\_icon](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-icon).

___

void **add\_theme\_stylebox\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), stylebox: [StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox))

Creates a local override for a theme [StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) with the specified `name`. Local overrides always take precedence when fetching theme items for the control. An override can be removed with [remove\_theme\_stylebox\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-remove-theme-stylebox-override).

See also [get\_theme\_stylebox](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-theme-stylebox) and [Control.add\_theme\_stylebox\_override](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-add-theme-stylebox-override) for more details.

___

void **begin\_bulk\_theme\_override**()

Prevents `*_theme_*_override` methods from emitting [NOTIFICATION\_THEME\_CHANGED](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-constant-notification-theme-changed) until [end\_bulk\_theme\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-end-bulk-theme-override) is called.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **can\_draw**() const

Returns whether the window is being drawn to the screen.

___

void **child\_controls\_changed**()

Requests an update of the **Window** size to fit underlying [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) nodes.

___

void **end\_bulk\_theme\_override**()

Ends a bulk theme override update. See [begin\_bulk\_theme\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-begin-bulk-theme-override).

___

[Vector2](https://docs.godotengine.org/en/stable/classes/class_vector2.html#class-vector2) **get\_contents\_minimum\_size**() const

Returns the combined minimum size from the child [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) nodes of the window. Use [child\_controls\_changed](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-child-controls-changed) to update it when child nodes have changed.

The value returned by this method can be overridden with [\_get\_contents\_minimum\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-private-method-get-contents-minimum-size).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **get\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags)) const

Returns `true` if the `flag` is set.

___

[LayoutDirection](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection) **get\_layout\_direction**() const

Returns layout direction and text writing direction.

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_position\_with\_decorations**() const

Returns the window's position including its border.

**Note:** If [visible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-visible) is `false`, this method returns the same value as [position](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-position).

___

[Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i) **get\_size\_with\_decorations**() const

Returns the window's size including its border.

**Note:** If [visible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-visible) is `false`, this method returns the same value as [size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-size).

___

[Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) **get\_theme\_color**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns a [Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a color item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for more details.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **get\_theme\_constant**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns a constant from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a constant item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for more details.

___

[float](https://docs.godotengine.org/en/stable/classes/class_float.html#class-float) **get\_theme\_default\_base\_scale**() const

Returns the default base scale value from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a valid [Theme.default\_base\_scale](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme-property-default-base-scale) value.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) **get\_theme\_default\_font**() const

Returns the default font from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a valid [Theme.default\_font](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme-property-default-font) value.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **get\_theme\_default\_font\_size**() const

Returns the default font size value from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a valid [Theme.default\_font\_size](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme-property-default-font-size) value.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) **get\_theme\_font**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns a [Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a font item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **get\_theme\_font\_size**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns a font size from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a font size item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[Texture2D](https://docs.godotengine.org/en/stable/classes/class_texture2d.html#class-texture2d) **get\_theme\_icon**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns an icon from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has an icon item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) **get\_theme\_stylebox**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns a [StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) from the first matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree if that [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) has a stylebox item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **get\_window\_id**() const

Returns the ID of the window.

___

void **grab\_focus**()

Causes the window to grab focus, allowing it to receive user input.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_focus**() const

Returns `true` if the window is focused.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_color**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns `true` if there is a matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree that has a color item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_color\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname)) const

Returns `true` if there is a local override for a theme [Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) with the specified `name` in this [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) node.

See [add\_theme\_color\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-color-override).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_constant**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns `true` if there is a matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree that has a constant item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_constant\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname)) const

Returns `true` if there is a local override for a theme constant with the specified `name` in this [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) node.

See [add\_theme\_constant\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-constant-override).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_font**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns `true` if there is a matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree that has a font item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_font\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname)) const

Returns `true` if there is a local override for a theme [Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) with the specified `name` in this [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) node.

See [add\_theme\_font\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-font-override).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_font\_size**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns `true` if there is a matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree that has a font size item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_font\_size\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname)) const

Returns `true` if there is a local override for a theme font size with the specified `name` in this [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) node.

See [add\_theme\_font\_size\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-font-size-override).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_icon**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns `true` if there is a matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree that has an icon item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_icon\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname)) const

Returns `true` if there is a local override for a theme icon with the specified `name` in this [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) node.

See [add\_theme\_icon\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-icon-override).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_stylebox**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname), theme\_type: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname) = &"") const

Returns `true` if there is a matching [Theme](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme) in the tree that has a stylebox item with the specified `name` and `theme_type`.

See [Control.get\_theme\_color](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control-method-get-theme-color) for details.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **has\_theme\_stylebox\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname)) const

Returns `true` if there is a local override for a theme [StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) with the specified `name` in this [Control](https://docs.godotengine.org/en/stable/classes/class_control.html#class-control) node.

See [add\_theme\_stylebox\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-stylebox-override).

___

void **hide**()

Hides the window. This is not the same as minimized state. Hidden window can't be interacted with and needs to be made visible with [show](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-show).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_embedded**() const

Returns `true` if the window is currently embedded in another window.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_layout\_rtl**() const

Returns `true` if layout is right-to-left.

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_maximize\_allowed**() const

Returns `true` if the window can be maximized (the maximize button is enabled).

___

[bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool) **is\_using\_font\_oversampling**() const

Returns `true` if font oversampling is enabled. See [set\_use\_font\_oversampling](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-use-font-oversampling).

___

void **move\_to\_center**()

Centers a native window on the current screen and an embedded window on its embedder [Viewport](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport).

___

void **move\_to\_foreground**()

**Deprecated:** Use [grab\_focus](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-grab-focus) instead.

Causes the window to grab focus, allowing it to receive user input.

___

Shows the **Window** and makes it transient (see [transient](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transient)). If `rect` is provided, it will be set as the **Window**'s size. Fails if called on the main window.

If [ProjectSettings.display/window/subwindows/embed\_subwindows](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-display-window-subwindows-embed-subwindows) is `true` (single-window mode), `rect`'s coordinates are global and relative to the main window's top-left corner (excluding window decorations). If `rect`'s position coordinates are negative, the window will be located outside the main window and may not be visible as a result.

If [ProjectSettings.display/window/subwindows/embed\_subwindows](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-display-window-subwindows-embed-subwindows) is `false` (multi-window mode), `rect`'s coordinates are global and relative to the top-left corner of the leftmost screen. If `rect`'s position coordinates are negative, the window will be placed at the top-left corner of the screen.

**Note:** `rect` must be in global coordinates if specified.

___

Popups the **Window** at the center of the current screen, with optionally given minimum size. If the **Window** is embedded, it will be centered in the parent [Viewport](https://docs.godotengine.org/en/stable/classes/class_viewport.html#class-viewport) instead.

**Note:** Calling it with the default value of `minsize` is equivalent to calling it with [size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-size).

___

Popups the **Window** centered inside its parent **Window**. `fallback_ratio` determines the maximum size of the **Window**, in relation to its parent.

**Note:** Calling it with the default value of `minsize` is equivalent to calling it with [size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-size).

___

If **Window** is embedded, popups the **Window** centered inside its embedder and sets its size as a `ratio` of embedder's size.

If **Window** is a native window, popups the **Window** centered inside the screen of its parent **Window** and sets its size as a `ratio` of the screen size.

___

Attempts to parent this dialog to the last exclusive window relative to `from_node`, and then calls [popup](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup) on it. The dialog must have no current parent, otherwise the method fails.

See also [set\_unparent\_when\_invisible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-unparent-when-invisible) and [Node.get\_last\_exclusive\_window](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-get-last-exclusive-window).

___

Attempts to parent this dialog to the last exclusive window relative to `from_node`, and then calls [popup\_centered](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-centered) on it. The dialog must have no current parent, otherwise the method fails.

See also [set\_unparent\_when\_invisible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-unparent-when-invisible) and [Node.get\_last\_exclusive\_window](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-get-last-exclusive-window).

___

Attempts to parent this dialog to the last exclusive window relative to `from_node`, and then calls [popup\_centered\_clamped](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-centered-clamped) on it. The dialog must have no current parent, otherwise the method fails.

See also [set\_unparent\_when\_invisible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-unparent-when-invisible) and [Node.get\_last\_exclusive\_window](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-get-last-exclusive-window).

___

Attempts to parent this dialog to the last exclusive window relative to `from_node`, and then calls [popup\_centered\_ratio](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-centered-ratio) on it. The dialog must have no current parent, otherwise the method fails.

See also [set\_unparent\_when\_invisible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-unparent-when-invisible) and [Node.get\_last\_exclusive\_window](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-get-last-exclusive-window).

___

Attempts to parent this dialog to the last exclusive window relative to `from_node`, and then calls [popup\_on\_parent](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup-on-parent) on it. The dialog must have no current parent, otherwise the method fails.

See also [set\_unparent\_when\_invisible](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-set-unparent-when-invisible) and [Node.get\_last\_exclusive\_window](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-get-last-exclusive-window).

___

Popups the **Window** with a position shifted by parent **Window**'s position. If the **Window** is embedded, has the same effect as [popup](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup).

___

void **remove\_theme\_color\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))

Removes a local override for a theme [Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) with the specified `name` previously added by [add\_theme\_color\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-color-override) or via the Inspector dock.

___

void **remove\_theme\_constant\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))

Removes a local override for a theme constant with the specified `name` previously added by [add\_theme\_constant\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-constant-override) or via the Inspector dock.

___

void **remove\_theme\_font\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))

Removes a local override for a theme [Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) with the specified `name` previously added by [add\_theme\_font\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-font-override) or via the Inspector dock.

___

void **remove\_theme\_font\_size\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))

Removes a local override for a theme font size with the specified `name` previously added by [add\_theme\_font\_size\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-font-size-override) or via the Inspector dock.

___

void **remove\_theme\_icon\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))

Removes a local override for a theme icon with the specified `name` previously added by [add\_theme\_icon\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-icon-override) or via the Inspector dock.

___

void **remove\_theme\_stylebox\_override**(name: [StringName](https://docs.godotengine.org/en/stable/classes/class_stringname.html#class-stringname))

Removes a local override for a theme [StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) with the specified `name` previously added by [add\_theme\_stylebox\_override](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-add-theme-stylebox-override) or via the Inspector dock.

___

void **request\_attention**()

Tells the OS that the **Window** needs an attention. This makes the window stand out in some way depending on the system, e.g. it might blink on the task bar.

___

void **reset\_size**()

Resets the size to the minimum size, which is the max of [min\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-min-size) and (if [wrap\_controls](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-wrap-controls) is enabled) [get\_contents\_minimum\_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-get-contents-minimum-size). This is equivalent to calling `set_size(Vector2i())` (or any size below the minimum).

___

void **set\_flag**(flag: [Flags](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-flags), enabled: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))

Sets a specified window flag.

___

void **set\_ime\_active**(active: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))

If `active` is `true`, enables system's native IME (Input Method Editor).

___

void **set\_ime\_position**(position: [Vector2i](https://docs.godotengine.org/en/stable/classes/class_vector2i.html#class-vector2i))

Moves IME to the given position.

___

void **set\_layout\_direction**(direction: [LayoutDirection](https://docs.godotengine.org/en/stable/classes/class_window.html#enum-window-layoutdirection))

Sets layout direction and text writing direction. Right-to-left layouts are necessary for certain languages (e.g. Arabic and Hebrew).

___

void **set\_unparent\_when\_invisible**(unparent: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))

If `unparent` is `true`, the window is automatically unparented when going invisible.

**Note:** Make sure to keep a reference to the node, otherwise it will be orphaned. You also need to manually call [Node.queue\_free](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-queue-free) to free the window if it's not parented.

___

void **set\_use\_font\_oversampling**(enable: [bool](https://docs.godotengine.org/en/stable/classes/class_bool.html#class-bool))

Enables font oversampling. This makes fonts look better when they are scaled up.

___

void **show**()

Makes the **Window** appear. This enables interactions with the **Window** and doesn't change any of its property other than visibility (unlike e.g. [popup](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-method-popup)).

___

## Theme Property Descriptions[¶](https://docs.godotengine.org/en/stable/classes/class_window.html#theme-property-descriptions "Permalink to this headline")

[Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) **title\_color** = `Color(0.875, 0.875, 0.875, 1)`

The color of the title's text.

___

[Color](https://docs.godotengine.org/en/stable/classes/class_color.html#class-color) **title\_outline\_modulate** = `Color(0, 0, 0, 1)`

The color of the title's text outline.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **close\_h\_offset** = `18`

Horizontal position offset of the close button.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **close\_v\_offset** = `24`

Vertical position offset of the close button.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **resize\_margin** = `4`

Defines the outside margin at which the window border can be grabbed with mouse and resized.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **title\_height** = `36`

Height of the title bar.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **title\_outline\_size** = `0`

The size of the title outline.

___

[Font](https://docs.godotengine.org/en/stable/classes/class_font.html#class-font) **title\_font**

The font used to draw the title.

___

[int](https://docs.godotengine.org/en/stable/classes/class_int.html#class-int) **title\_font\_size**

The size of the title font.

___

[Texture2D](https://docs.godotengine.org/en/stable/classes/class_texture2d.html#class-texture2d) **close**

The icon for the close button.

___

[Texture2D](https://docs.godotengine.org/en/stable/classes/class_texture2d.html#class-texture2d) **close\_pressed**

The icon for the close button when it's being pressed.

___

[StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) **embedded\_border**

The background style used when the **Window** is embedded. Note that this is drawn only under the window's content, excluding the title. For proper borders and title bar style, you can use `expand_margin_*` properties of [StyleBoxFlat](https://docs.godotengine.org/en/stable/classes/class_styleboxflat.html#class-styleboxflat).

**Note:** The content background will not be visible unless [transparent](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-transparent) is enabled.

___

[StyleBox](https://docs.godotengine.org/en/stable/classes/class_stylebox.html#class-stylebox) **embedded\_unfocused\_border**

The background style used when the **Window** is embedded and unfocused.