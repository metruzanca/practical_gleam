// https://x.com/ChShersh/status/1886499767641104712/photo/1

import gleam/result
import gleam/string

fn char_code(char: String) {
  let assert [first, ..] = string.to_utf_codepoints(char)
  string.utf_codepoint_to_int(first)
}

fn parse_digit(c: String) {
  case c {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ->
      Ok(char_code(c) - char_code("0"))
    "a" | "b" | "c" | "d" | "e" | "f" -> {
      Ok(char_code(c) - char_code("a") + 10)
    }
    _ -> Error("Invalid character(s) in Hex string")
  }
}

// import gleam/bool
// A bit more imperative, prettier, but slower.
// fn parse_digit2(c: String) {
//   let code = char_code(c)

//   let zero_code = char_code("0")
//   use <- bool.guard(
//     code >= zero_code && code <= char_code("9"),
//     Ok(code - zero_code),
//   )

//   let a_code = char_code("a")
//   use <- bool.guard(
//     code >= a_code && code <= char_code("f"),
//     Ok(code - a_code + 10),
//   )

//   Error("Invalid character(s) in Hex string")
// }

fn parse_channel(c1: String, c2: String) {
  use digit1 <- result.try(parse_digit(c1))
  use digit2 <- result.try(parse_digit(c2))

  Ok(digit1 * 16 + digit2)
}

pub fn hex_to_rgb(hex: String) {
  let just_hex = case hex {
    "#" <> hex -> hex
    _ -> hex
  }

  case string.to_graphemes(just_hex) {
    [r1, g1, b1] -> {
      use red <- result.try(parse_channel(r1, r1))
      use green <- result.try(parse_channel(g1, g1))
      use blue <- result.try(parse_channel(b1, b1))

      Ok(#(red, green, blue))
    }
    [r1, r2, g1, g2, b1, b2] -> {
      use red <- result.try(parse_channel(r1, r2))
      use green <- result.try(parse_channel(g1, g2))
      use blue <- result.try(parse_channel(b1, b2))

      Ok(#(red, green, blue))
    }
    _ -> Error("Hex string not correct length")
  }
}
