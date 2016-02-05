module Html (..) where

{-| This file is organized roughly in order of popularity. The tags which you'd
expect to use frequently will be closer to the top.

# Custom Nodes
@docs text, node, Html, Attribute, addAttribute, render

# Conversions
@docs toElement

# Headers
@docs h1, h2, h3, h4, h5, h6

# Grouping Content
@docs div, p, hr, pre, blockquote

# Text
@docs span, a, code, em, strong, i, b, u, sub, sup, br

# Lists
@docs ol, ul, li, dl, dt, dd

# Emdedded Content
@docs img, iframe, canvas, svg, math

# Inputs
@docs form, input, textarea, button, select, option

# Sections
@docs section, nav, article, aside, header, footer, address, main', body

# Figures
@docs figure, figcaption

# Tables
@docs table, caption, colgroup, col, tbody, thead, tfoot, tr, td, th


# Less Common Elements

## Less Common Inputs
@docs fieldset, legend, label, datalist, optgroup, keygen, output, progress, meter


## Audio and Video
@docs audio, video, source, track

## Embedded Objects
@docs embed, object, param

## Text Edits
@docs ins, del

## Semantic Text
@docs small, cite, dfn, abbr, time, var, samp, kbd, s, q

## Less Common Text Tags
@docs mark, ruby, rt, rp, bdi, bdo, wbr

# Interactive Elements
@docs details, summary, menuitem, menu

-}

import Graphics.Element exposing (Element)
import VirtualDom


{-| The core building block used to build up HTML. It is backed by
`VirtualDom.Node` in `evancz/virtual-dom` but that is not a super crucial
detail.
-}
type Html
  = Node String (List Attribute) (List Html)
  | Text String


{-| Set attributes on your `Html`.
-}
type alias Attribute =
  VirtualDom.Property


{-| General way to create HTML nodes. It is used to define all of the helper
functions in this library.

    div : List Attribute -> List Html -> Html
    div attributes children =
        node "div" attributes children

You can use this to create custom nodes if you need to create something that
is not covered by the helper functions in this library.
-}
node : String -> List Attribute -> List Html -> Html
node =
  Node


{-| A method for adding an HTML attribute
-}
addAttribute : Attribute -> Html -> Html
addAttribute attr node =
  case node of
    Node name attrs children ->
      (Node name (attr :: attrs) children)

    Text string ->
      Text string


{-| A method for adding an HTML child
-}
addChild : Html -> Html -> Html
addChild child parent =
  case parent of
    Node name attrs children ->
      (Node name attrs (List.append children [ child ]))

    Text string ->
      Text string


{-| A method for adding an HTML children
-}
addChildren : List Html -> Html -> Html
addChildren newChildren parent =
  case parent of
    Node name attrs children ->
      (Node name attrs (List.append children newChildren))

    Text string ->
      Text string


{-| render must be used once you have constructed your html object
-}
render : Html -> VirtualDom.Node
render html =
  case html of
    Node name attributes children ->
      VirtualDom.node name attributes (List.map render children)

    Text string ->
      VirtualDom.text string


{-| Just put plain text in the DOM. It will escape the string so that it appears
exactly as you specify.

      text "Hello World!"
-}
text : String -> Html
text =
  Text



-- TODO: fix fromElement


{-| Embed HTML in Elements. Useful if your app is written primarily with
Elements, but you need to switch over to HTML for some small section.
-}
toElement : Int -> Int -> Html -> Element
toElement x y html =
  VirtualDom.toElement x y (render html)


{-| Embed Elements in HTML. Useful if you have some component written with
Elements or that uses `collage` that you want to embed in a larger HTML
component.
fromElement : Element -> Html
fromElement x y html =
  VirtualDom.fromElement
-}



-- SECTIONS


{-| Represents the content of an HTML document. There is only one `body`
element in a document.
-}
body : Html
body =
  node "body" [] []


{-| Defines a section in a document.
-}
section : Html
section =
  node "section" [] []


{-| Defines a section that contains only navigation links.
-}
nav : Html
nav =
  node "nav" [] []


{-| Defines self-contained content that could exist independently of the rest
of the content.
-}
article : Html
article =
  node "article" [] []


{-| Defines some content loosely related to the page content. If it is removed,
the remaining content still makes sense.
-}
aside : Html
aside =
  node "aside" [] []


{-| -}
h1 : Html
h1 =
  node "h1" [] []


{-| -}
h2 : Html
h2 =
  node "h2" [] []


{-| -}
h3 : Html
h3 =
  node "h3" [] []


{-| -}
h4 : Html
h4 =
  node "h4" [] []


{-| -}
h5 : Html
h5 =
  node "h5" [] []


{-| -}
h6 : Html
h6 =
  node "h6" [] []


{-| Defines the header of a page or section. It often contains a logo, the
title of the web site, and a navigational table of content.
-}
header : Html
header =
  node "header" [] []


{-| Defines the footer for a page or section. It often contains a copyright
notice, some links to legal information, or addresses to give feedback.
-}
footer : Html
footer =
  node "footer" [] []


{-| Defines a section containing contact information.
-}
address : Html
address =
  node "address" [] []


{-| Defines the main or important content in the document. There is only one
`main` element in the document.
-}
main' : Html
main' =
  node "main" [] []



-- GROUPING CONTENT


{-| Defines a portion that should be displayed as a paragraph.
-}
p : Html
p =
  node "p" [] []


{-| Represents a thematic break between paragraphs of a section or article or
any longer content.
-}
hr : Html
hr =
  node "hr" [] []


{-| Indicates that its content is preformatted and that this format must be
preserved.
-}
pre : Html
pre =
  node "pre" [] []


{-| Represents a content that is quoted from another source.
-}
blockquote : Html
blockquote =
  node "blockquote" [] []


{-| Defines an ordered list of items.
-}
ol : Html
ol =
  node "ol" [] []


{-| Defines an unordered list of items.
-}
ul : Html
ul =
  node "ul" [] []


{-| Defines a item of an enumeration list.
-}
li : Html
li =
  node "li" [] []


{-| Defines a definition list, that is, a list of terms and their associated
definitions.
-}
dl : Html
dl =
  node "dl" [] []


{-| Represents a term defined by the next `dd`.
-}
dt : Html
dt =
  node "dt" [] []


{-| Represents the definition of the terms immediately listed before it.
-}
dd : Html
dd =
  node "dd" [] []


{-| Represents a figure illustrated as part of the document.
-}
figure : Html
figure =
  node "figure" [] []


{-| Represents the legend of a figure.
-}
figcaption : Html
figcaption =
  node "figcaption" [] []


{-| Represents a generic container with no special meaning.
-}
div : Html
div =
  node "div" [] []



-- TEXT LEVEL SEMANTIC


{-| Represents a hyperlink, linking to another resource.
-}
a : Html
a =
  node "a" [] []


{-| Represents emphasized text, like a stress accent.
-}
em : Html
em =
  node "em" [] []


{-| Represents especially important text.
-}
strong : Html
strong =
  node "strong" [] []


{-| Represents a side comment, that is, text like a disclaimer or a
copyright, which is not essential to the comprehension of the document.
-}
small : Html
small =
  node "small" [] []


{-| Represents content that is no longer accurate or relevant.
-}
s : Html
s =
  node "s" [] []


{-| Represents the title of a work.
-}
cite : Html
cite =
  node "cite" [] []


{-| Represents an inline quotation.
-}
q : Html
q =
  node "q" [] []


{-| Represents a term whose definition is contained in its nearest ancestor
content.
-}
dfn : Html
dfn =
  node "dfn" [] []


{-| Represents an abbreviation or an acronym; the expansion of the
abbreviation can be represented in the title attribute.
-}
abbr : Html
abbr =
  node "abbr" [] []


{-| Represents a date and time value; the machine-readable equivalent can be
represented in the datetime attribute.
-}
time : Html
time =
  node "time" [] []


{-| Represents computer code.
-}
code : Html
code =
  node "code" [] []


{-| Represents a variable. Specific cases where it should be used include an
actual mathematical expression or programming context, an identifier
representing a constant, a symbol identifying a physical quantity, a function
parameter, or a mere placeholder in prose.
-}
var : Html
var =
  node "var" [] []


{-| Represents the output of a program or a computer.
-}
samp : Html
samp =
  node "samp" [] []


{-| Represents user input, often from the keyboard, but not necessarily; it
may represent other input, like transcribed voice commands.
-}
kbd : Html
kbd =
  node "kbd" [] []


{-| Represent a subscript.
-}
sub : Html
sub =
  node "sub" [] []


{-| Represent a superscript.
-}
sup : Html
sup =
  node "sup" [] []


{-| Represents some text in an alternate voice or mood, or at least of
different quality, such as a taxonomic designation, a technical term, an
idiomatic phrase, a thought, or a ship name.
-}
i : Html
i =
  node "i" [] []


{-| Represents a text which to which attention is drawn for utilitarian
purposes. It doesn't convey extra importance and doesn't imply an alternate
voice.
-}
b : Html
b =
  node "b" [] []


{-| Represents a non-textual annoatation for which the conventional
presentation is underlining, such labeling the text as being misspelt or
labeling a proper name in Chinese text.
-}
u : Html
u =
  node "u" [] []


{-| Represents text highlighted for reference purposes, that is for its
relevance in another context.
-}
mark : Html
mark =
  node "mark" [] []


{-| Represents content to be marked with ruby annotations, short runs of text
presented alongside the text. This is often used in conjunction with East Asian
language where the annotations act as a guide for pronunciation, like the
Japanese furigana.
-}
ruby : Html
ruby =
  node "ruby" [] []


{-| Represents the text of a ruby annotation.
-}
rt : Html
rt =
  node "rt" [] []


{-| Represents parenthesis around a ruby annotation, used to display the
annotation in an alternate way by browsers not supporting the standard display
for annotations.
-}
rp : Html
rp =
  node "rp" [] []


{-| Represents text that must be isolated from its surrounding for
bidirectional text formatting. It allows embedding a span of text with a
different, or unknown, directionality.
-}
bdi : Html
bdi =
  node "bdi" [] []


{-| Represents the directionality of its children, in order to explicitly
override the Unicode bidirectional algorithm.
-}
bdo : Html
bdo =
  node "bdo" [] []


{-| Represents text with no specific meaning. This has to be used when no other
text-semantic element conveys an adequate meaning, which, in this case, is
often brought by global attributes like `class`, `lang`, or `dir`.
-}
span : Html
span =
  node "span" [] []


{-| Represents a line break.
-}
br : Html
br =
  node "br" [] []


{-| Represents a line break opportunity, that is a suggested point for
wrapping text in order to improve readability of text split on several lines.
-}
wbr : Html
wbr =
  node "wbr" [] []



-- EDITS


{-| Defines an addition to the document.
-}
ins : Html
ins =
  node "ins" [] []


{-| Defines a removal from the document.
-}
del : Html
del =
  node "del" [] []



-- EMBEDDED CONTENT


{-| Represents an image.
-}
img : Html
img =
  node "img" [] []


{-| Embedded an HTML document.
-}
iframe : Html
iframe =
  node "iframe" [] []


{-| Represents a integration point for an external, often non-HTML,
application or interactive content.
-}
embed : Html
embed =
  node "embed" [] []


{-| Represents an external resource, which is treated as an image, an HTML
sub-document, or an external resource to be processed by a plug-in.
-}
object : Html
object =
  node "object" [] []


{-| Defines parameters for use by plug-ins invoked by `object` elements.
-}
param : Html
param =
  node "param" [] []


{-| Represents a video, the associated audio and captions, and controls.
-}
video : Html
video =
  node "video" [] []


{-| Represents a sound or audio stream.
-}
audio : Html
audio =
  node "audio" [] []


{-| Allows authors to specify alternative media resources for media elements
like `video` or `audio`.
-}
source : Html
source =
  node "source" [] []


{-| Allows authors to specify timed text track for media elements like `video`
or `audio`.
-}
track : Html
track =
  node "track" [] []


{-| Represents a bitmap area for graphics rendering.
-}
canvas : Html
canvas =
  node "canvas" [] []



{- - TODO: get a better way to disambiguate imports
then expose these functions
-}


{-| Defines an embedded vectorial image.
-}
svg : Html
svg =
  node "svg" [] []


{-| Defines a mathematical formula.
-}
math : Html
math =
  node "math" [] []



-- TABULAR DATA


{-| Represents data with more than one dimension.
-}
table : Html
table =
  node "table" [] []


{-| Represents the title of a table.
-}
caption : Html
caption =
  node "caption" [] []


{-| Represents a set of one or more columns of a table.
-}
colgroup : Html
colgroup =
  node "colgroup" [] []


{-| Represents a column of a table.
-}
col : Html
col =
  node "col" [] []


{-| Represents the block of rows that describes the concrete data of a table.
-}
tbody : Html
tbody =
  node "tbody" [] []


{-| Represents the block of rows that describes the column labels of a table.
-}
thead : Html
thead =
  node "thead" [] []


{-| Represents the block of rows that describes the column summaries of a table.
-}
tfoot : Html
tfoot =
  node "tfoot" [] []


{-| Represents a row of cells in a table.
-}
tr : Html
tr =
  node "tr" [] []


{-| Represents a data cell in a table.
-}
td : Html
td =
  node "td" [] []


{-| Represents a header cell in a table.
-}
th : Html
th =
  node "th" [] []



-- FORMS


{-| Represents a form, consisting of controls, that can be submitted to a
server for processing.
-}
form : Html
form =
  node "form" [] []


{-| Represents a set of controls.
-}
fieldset : Html
fieldset =
  node "fieldset" [] []


{-| Represents the caption for a `fieldset`.
-}
legend : Html
legend =
  node "legend" [] []


{-| Represents the caption of a form control.
-}
label : Html
label =
  node "label" [] []


{-| Represents a typed data field allowing the user to edit the data.
-}
input : Html
input =
  node "input" [] []


{-| Represents a button.
-}
button : Html
button =
  node "button" [] []


{-| Represents a control allowing selection among a set of options.
-}
select : Html
select =
  node "select" [] []


{-| Represents a set of predefined options for other controls.
-}
datalist : Html
datalist =
  node "datalist" [] []


{-| Represents a set of options, logically grouped.
-}
optgroup : Html
optgroup =
  node "optgroup" [] []


{-| Represents an option in a `select` element or a suggestion of a `datalist`
element.
-}
option : Html
option =
  node "option" [] []


{-| Represents a multiline text edit control.
-}
textarea : Html
textarea =
  node "textarea" [] []


{-| Represents a key-pair generator control.
-}
keygen : Html
keygen =
  node "keygen" [] []


{-| Represents the result of a calculation.
-}
output : Html
output =
  node "output" [] []


{-| Represents the completion progress of a task.
-}
progress : Html
progress =
  node "progress" [] []


{-| Represents a scalar measurement (or a fractional value), within a known
range.
-}
meter : Html
meter =
  node "meter" [] []



-- INTERACTIVE ELEMENTS


{-| Represents a widget from which the user can obtain additional information
or controls.
-}
details : Html
details =
  node "details" [] []


{-| Represents a summary, caption, or legend for a given `details`.
-}
summary : Html
summary =
  node "summary" [] []


{-| Represents a command that the user can invoke.
-}
menuitem : Html
menuitem =
  node "menuitem" [] []


{-| Represents a list of commands.
-}
menu : Html
menu =
  node "menu" [] []
