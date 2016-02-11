module Main (..) where

import Html exposing (Html, Attribute, render, addChild, addAttribute, text, toElement, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String
import VirtualDom


main =
  StartApp.start { model = "", view = view, update = update }


update newStr oldStr =
  newStr


view : Address String -> String -> VirtualDom.Node
view address string =
  render
    (div
      |> addChild
          (input
            |> addAttribute (placeholder "Text to reverse")
            |> addAttribute (value string)
            |> addAttribute (on "input" targetValue (Signal.message address))
            |> addAttribute (myStyle)
          )
      |> addChild
          (div
            |> addAttribute myStyle
            |> addChild (text (String.reverse string))
          )
    )


myStyle : Attribute
myStyle =
  style
    [ ( "width", "100%" )
    , ( "height", "40px" )
    , ( "padding", "10px 0" )
    , ( "font-size", "2em" )
    , ( "text-align", "center" )
    ]
module Main (..) where

import Html exposing (Html, Attribute, render, addChild, addAttribute, text, toElement, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String
import VirtualDom


main =
  StartApp.start { model = "", view = view, update = update }


update newStr oldStr =
  newStr


view : Address String -> String -> VirtualDom.Node
view address string =
  render
    (div
      |> addChild
          (input
            |> addAttribute (placeholder "Text to reverse")
            |> addAttribute (value string)
            |> addAttribute (on "input" targetValue (Signal.message address))
            |> addAttribute (myStyle)
          )
      |> addChild
          (div
            |> addAttribute myStyle
            |> addChild (text (String.reverse string))
          )
    )


myStyle : Attribute
myStyle =
  style
    [ ( "width", "100%" )
    , ( "height", "40px" )
    , ( "padding", "10px 0" )
    , ( "font-size", "2em" )
    , ( "text-align", "center" )
    ]
