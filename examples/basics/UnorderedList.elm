module Main (..) where

import Html exposing (render, addChild, addAttribute, li, text, ul)
import Html.Attributes exposing (class)


{-| This snippet uses the <ul> and <li> tags to create an unorderd
list of French grocery items. Notice that all occurrences of 'ul'
and 'li' are followed by two lists. The first list is for any HTML
attributes, and the second list is all the HTML nodes inside the
tag.

Et maintenant le voyage au supermarché!
-}
main =
  render
    (ul
      |> addAttribute (class "grocery-list")
      |> addChild (li |> addChild (text "Pamplemousse"))
      |> addChild (li |> addChild (text "Ananas"))
      |> addChild (li |> addChild (text "Jus d'orange"))
      |> addChild (li |> addChild (text "Boeuf"))
      |> addChild (li |> addChild (text "Soupe du jour"))
      |> addChild (li |> addChild (text "Camembert"))
      |> addChild (li |> addChild (text "Jacques Cousteau"))
      |> addChild (li |> addChild (text "Baguette"))
    )



-- Thanks to "Flight of the Conchords" for creating "Foux Du Fafa"
