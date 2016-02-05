module Main (..) where

import Html exposing (Html, Attribute, render, addChild, addAttribute, div, input, span, text, toElement)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String
import VirtualDom


main =
  StartApp.start { model = empty, view = view, update = update }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


empty : Model
empty =
  Model "" "" ""



-- UPDATE


type Action
  = Name String
  | Password String
  | PasswordAgain String


update : Action -> Model -> Model
update action model =
  case action of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Address Action -> Model -> VirtualDom.Node
view address model =
  render
    (let
      validationMessage =
        if model.password == model.passwordAgain then
          span
            |> addAttribute (style [ ( "color", "green" ) ])
            |> addChild (text "Passwords Match!")
        else
          span
            |> addAttribute (style [ ( "color", "red" ) ])
            |> addChild (text "Passwords do not match :(")
     in
      div
        |> addChild (field "text" address Name "User Name" model.name)
        |> addChild (field "password" address Password "Password" model.password)
        |> addChild (field "password" address PasswordAgain "Re-enter Password" model.passwordAgain)
        |> addChild
            (div
              |> addAttribute (fieldNameStyle "300px")
              |> addChild (validationMessage)
            )
    )


field : String -> Address Action -> (String -> Action) -> String -> String -> Html
field fieldType address toAction name content =
  div
    |> addChild
        (div
          |> addAttribute (fieldNameStyle "160px")
          |> addChild (text name)
        )
    |> addChild
        (input
          |> addAttribute (type' fieldType)
          |> addAttribute (placeholder name)
          |> addAttribute (value content)
          |> addAttribute (on "input" targetValue (\string -> Signal.message address (toAction string)))
        )


fieldNameStyle : String -> Attribute
fieldNameStyle px =
  style
    [ ( "width", px )
    , ( "padding", "10px" )
    , ( "text-align", "right" )
    , ( "display", "inline-block" )
    ]
