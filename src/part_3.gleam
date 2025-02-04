// https://x.com/ChShersh/status/1886499767641104712/photo/1

import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string

pub type RGBColor =
  #(Int, Int, Int)

pub type HexColor =
  String

fn char_code(char: String) {
  let assert [first, ..] = string.to_utf_codepoints(char)
  string.utf_codepoint_to_int(first)
}

fn of_hex_digit(c: String) {
  case c {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ->
      Some(char_code(c) - char_code("0"))
    "a" | "b" | "c" | "d" | "e" | "f" -> {
      Some(char_code(c) - char_code("a") + 10)
    }
    _ -> None
  }
}

fn parse_channel(c1: String, c2: String) {
  let assert Some(digit1) = of_hex_digit(c1)
  let assert Some(digit2) = of_hex_digit(c2)
  option.Some(digit1 * 16 + digit2)
}

pub fn hex_to_rgb(hex: String) {
  let just_hex = case hex {
    "#" <> hex -> hex
    _ -> hex
  }

  case string.to_graphemes(just_hex) {
    [r1, r2, g1, g2, b1, b2] -> {
      let assert Some(red) = parse_channel(r1, r2)
      let assert Some(green) = parse_channel(g1, g2)
      let assert Some(blue) = parse_channel(b1, b2)
      #(red, green, blue)
    }
    _ -> #(0, 0, 0)
  }
}
