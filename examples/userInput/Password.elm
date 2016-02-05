module Main (..) where

import Html exposing (Html, Attribute, addChild, addAttribute, render, text, toElement, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
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
            |> addAttribute (type' "password")
            |> addAttribute (placeholder "Password")
            |> addAttribute (value string)
            |> addAttribute (on "input" targetValue (Signal.message address))
            |> addAttribute (myStyle)
          )
      |> addChild
          (div
            |> addAttribute myStyle
            |> addChild (text string)
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
