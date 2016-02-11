module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetChecked)
import Signal exposing (Address)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = initialModel, view = view, update = update }



-- MODEL


type alias Model =
  { style : Style
  }


type Style
  = Red
  | Underline
  | Bold


initialModel =
  { style = Bold }



-- UPDATE


update newStyle model =
  { model | style = newStyle }



-- VIEW


view address model =
  render
    (div
      |> addChild
          (span
            |> addAttribute (toStyle model)
            |> addChild (text "Hello, how are you?!")
          )
      |> addChild br
      |> addChildren (radio address model Red "red")
      |> addChildren (radio address model Underline "underline")
      |> addChildren (radio address model Bold "bold")
    )


toStyle model =
  style
    <| case model.style of
        Red ->
          [ ( "color", "red" ) ]

        Underline ->
          [ ( "text-decoration", "underline" ) ]

        Bold ->
          [ ( "font-weight", "bold" ) ]


radio : Address Style -> Model -> Style -> String -> List Html
radio address model style name =
  [ input
      |> addAttribute (type' "radio")
      |> addAttribute (checked (model.style == style))
      |> addAttribute (on "change" targetChecked (\_ -> Signal.message address style))
  , text name
  , br
  ]
module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetChecked)
import Signal exposing (Address)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = initialModel, view = view, update = update }



-- MODEL


type alias Model =
  { style : Style
  }


type Style
  = Red
  | Underline
  | Bold


initialModel =
  { style = Bold }



-- UPDATE


update newStyle model =
  { model | style = newStyle }



-- VIEW


view address model =
  render
    (div
      |> addChild
          (span
            |> addAttribute (toStyle model)
            |> addChild (text "Hello, how are you?!")
          )
      |> addChild br
      |> addChildren (radio address model Red "red")
      |> addChildren (radio address model Underline "underline")
      |> addChildren (radio address model Bold "bold")
    )


toStyle model =
  style
    <| case model.style of
        Red ->
          [ ( "color", "red" ) ]

        Underline ->
          [ ( "text-decoration", "underline" ) ]

        Bold ->
          [ ( "font-weight", "bold" ) ]


radio : Address Style -> Model -> Style -> String -> List Html
radio address model style name =
  [ input
      |> addAttribute (type' "radio")
      |> addAttribute (checked (model.style == style))
      |> addAttribute (on "change" targetChecked (\_ -> Signal.message address style))
  , text name
  , br
  ]
