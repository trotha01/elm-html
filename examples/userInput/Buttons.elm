module Main (..) where

import Html exposing (render, addChild, addAttribute, div, button, text)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp


{-| Read more about StartApp and how this works at:

    https://github.com/evancz/start-app

The rough idea is that we just specify a model, a way to view it,
and a way to update it. That's all there is to it!
-}
main =
  StartApp.start { model = 0, view = view, update = update }


view address model =
  render
    (div
      |> addChild
          (button
            |> addAttribute (onClick address Decrement)
            |> addChild (text "-")
          )
      |> addChild
          (div |> addChild (text (toString model)))
      |> addChild (button |> addAttribute (onClick address Increment) |> addChild (text "+"))
    )


type Action
  = Increment
  | Decrement


update action model =
  case action of
    Increment ->
      model + 1

    Decrement ->
      model - 1
