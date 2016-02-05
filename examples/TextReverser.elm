module TextReverser (..) where

import VirtualDom
import Html exposing (Html, Attribute, render, addAttribute, addChild, text, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import String


-- VIEW


view : String -> Html
view string =
  div
    |> addChild (stringInput string)
    |> addChild (reversedString string)


reversedString : String -> Html
reversedString string =
  div
    |> addAttribute myStyle
    |> addChild (text (String.reverse string))


stringInput : String -> Html
stringInput string =
  input
    |> addAttribute (placeholder "Text to reverse")
    |> addAttribute (value string)
    |> addAttribute (on "input" targetValue (Signal.message actions.address))
    |> addAttribute (myStyle)


myStyle : Attribute
myStyle =
  style
    [ ( "width", "100%" )
    , ( "height", "40px" )
    , ( "padding", "10px 0" )
    , ( "font-size", "2em" )
    , ( "text-align", "center" )
    ]



-- SIGNALS


main : Signal VirtualDom.Node
main =
  Signal.map (view >> render) actions.signal


actions : Signal.Mailbox String
actions =
  Signal.mailbox ""
