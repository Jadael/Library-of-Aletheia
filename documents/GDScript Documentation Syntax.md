---
document_id: 0c3238e7-d9ea-4301-bb70-ec63492cb6a2
version_hash: b99371afb14aeab3973bcbfe32d35245
---
In GDScript, comments can be used to document your code and add descriptions to the members of a script. There are two differences between a normal comment and a documentation comment. Firstly, a documentation comment should start with double hash symbols `##`. Secondly, it must immediately precede a script member, or for script descriptions, be placed at the top of the script. If an exported variable is documented, its description is used as a tooltip in the editor. This documentation can be generated as XML files by the editor.

## Documenting a script

Comments documenting a script must come before any member documentation. A suggested format for script documentation can be divided into three parts.

-   A brief description of the script. Lives at the very beginning of the documentation section.
-   Detailed description. Use one blank line to separate the description from the brief.
-   Tags for Tutorials and deprecated/experimental marks.

To separate these from each other, the documentation comments use special tags. The tag must be at the beginning of a line (ignoring preceding white space) and must have the format `@`, followed by the keyword.

### Tags

- @tutorial: https://example.com
- @tutorial(The Title Here): https://example.com
- @deprecated
- @deprecated: Use [AnotherClass] instead.
- @experimental: This class is unstable.

For example:

```
extends Node2D
## A brief description of the class's role and functionality.
##
## The description of the script, what it can do,
## and any further detail.
##
## @tutorial:             https://example.com/tutorial_1
## @tutorial(Tutorial 2): https://example.com/tutorial_2
## @experimental
```

Warning

If there is any space in between the tag name and colon, for example `@tutorial  :`, it won't be treated as a valid tag and will be ignored.

Note

When the description spans multiple lines, the preceding and trailing white spaces will be stripped and joined with a single space. To preserve the line break use `[br]`. See also [BBCode and class reference] below.

## Documenting script members

Members that are applicable for documentation:

-   Inner class
-   Constant
-   Function
-   Signal
-   Variable
-   Enum
-   Enum value

Documentation of a script member must immediately precede the member or its annotations if it has any. The description can have more than one line but every line must start with the double hash symbol `##` to be considered as part of the documentation.

### Tags

Example:

```
## The description of the variable.
## @deprecated: Use [member other_var] instead.
var my_var
```

You can use inline documentation comments:

```
enum MyEnum { ## My enum.
VALUE_A = 0, ## Value A.
VALUE_B = 1, ## Value B.
}

const MY_CONST = 1 ## My constant.

var my_var ## My variable.

signal my_signal ## My signal.

func my_func(): ## My func.
pass

class MyClass: ## My class.
pass
```

The script documentation will update in the editor help window every time the script is updated. If any member variable or function name starts with an underscore, it will be treated as private. It will not appear in the documentation and will be ignored in the help window.

## Complete script example

```
extends Node2D
## A brief description of the class's role and functionality.
##
## The description of the script, what it can do,
## and any further detail.
##
## @tutorial:             https://example.com/tutorial_1
## @tutorial(Tutorial 2): https://example.com/tutorial_2
## @experimental

## The description of a constant.
const GRAVITY = 9.8

## The description of a signal.
signal my_signal

## This is a description of the below enum.
enum Direction {
## Direction up.
UP = 0,
## Direction down.
DOWN = 1,
## Direction left.
LEFT = 2,
## Direction right.
RIGHT = 3,
}

## The description of the variable v1.
var v1

## This is a multiline description of the variable v2.[br]
## The type information below will be extracted for the documentation.
var v2: int

## If the member has any annotation, the annotation should
## immediately precede it.
@export
var v3 := some_func()


## As the following function is documented, even though its name starts with
## an underscore, it will appear in the help window.
func _fn(p1: int, p2: String) - int:
return 0


# The below function isn't documented and its name starts with an underscore
# so it will treated as private and will not be shown in the help window.
func _internal() - void:
pass


## Documenting an inner class.
##
## The same rules apply here. The documentation must
## immediately precede the class definition.
##
## @tutorial: https://example.com/tutorial
## @experimental
class Inner:

## Inner class variable v4.
var v4


## Inner class function fn.
func fn(): pass
```

## `@deprecated` and `@experimental` tags

You can mark a class or any of its members as deprecated or experimental. This will add the corresponding indicator in the built-in documentation viewer. Optionally, you can provide a short message explaining why the API is not recommended. This can be especially useful for plugin and library creators.

![../../../_images/deprecated_and_experimental_tags.webp](https://docs.godotengine.org/en/stable/_images/deprecated_and_experimental_tags.webp)

-   **Deprecated** marks a non-recommended API that is subject to removal or incompatible change in a future major release. Usually the API is kept for backwards compatibility.
-   **Experimental** marks a new unstable API that may be changed or removed in the current major branch. Using this API is not recommended in production code.