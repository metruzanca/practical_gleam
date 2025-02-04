import gleam/list
import gleeunit/should
import part_3

pub fn hello_world_test() {
  [
    #("#ff0000", #(255, 0, 0)),
    #("ff0000", #(255, 0, 0)),
    #("00ffff", #(0, 255, 255)),
  ]
  |> list.each(fn(data) {
    let #(input, expected) = data
    should.equal(part_3.hex_to_rgb(input), expected)
  })
}
