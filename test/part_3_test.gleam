import gleam/list
import gleeunit/should
import part_3

pub fn hex_to_rgb_success_test() {
  [
    #("#ff0000", Ok(#(255, 0, 0))),
    #("ff0000", Ok(#(255, 0, 0))),
    #("00ffff", Ok(#(0, 255, 255))),
    #("#ff0", Ok(#(255, 255, 0))),
    #("fff", Ok(#(255, 255, 255))),
    #("nanana", Error("Invalid character(s) in Hex string")),
    #("too long", Error("Hex string not correct length")),
    #("short", Error("Hex string not correct length")),
  ]
  |> list.each(fn(data) {
    let #(input, expected) = data
    should.equal(part_3.hex_to_rgb(input), expected)
  })
}
