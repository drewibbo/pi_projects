// define the matrix font
char matrixFont[86][6] = {
{0x00, 0x00, 0x00, 0x00, 0x00, 0x00}, //  Space
{0x00, 0x00, 0x00, 0xFD, 0x00, 0x00}, //  !
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block // missing "
{0x00, 0x24, 0xFF, 0x24, 0xFF, 0x24}, //  #
{0x00, 0x12, 0x2A, 0x7F, 0x2A, 0x24}, //  $
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block// missing %
{0x00, 0x76, 0x89, 0x95, 0x62, 0x05}, //  &
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block// missing '
{0x00, 0x00, 0x3C, 0x42, 0x81, 0x00}, //  (
{0x00, 0x00, 0x81, 0x42, 0x3C, 0x00}, //  )
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block// missing *
{0x00, 0x08, 0x08, 0x3E, 0x08, 0x08}, //  ""+""
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block// missing ,
{0x00, 0x08, 0x08, 0x08, 0x08, 0x08}, //  -
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block // missing .
{0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, //  5x8 block // missing /
{0x00, 0x7E, 0x89, 0x91, 0xA1, 0x7E}, //  0
{0x00, 0x00, 0x41, 0xFF, 0x01, 0x00}, //  1
{0x00, 0x43, 0x85, 0x89, 0x91, 0x61}, //  2
{0x00, 0x42, 0x81, 0x91, 0x91, 0x6E}, //  3
{0x00, 0x18, 0x28, 0x48, 0xFF, 0x08}, //  4
{0x00, 0xF2, 0x91, 0x91, 0x91, 0x8E}, //  5
{0x00, 0x1E, 0x29, 0x49, 0x89, 0x86}, //  6
{0x00, 0x80, 0x8F, 0x90, 0xA0, 0xC0}, //  7
{0x00, 0x6E, 0x91, 0x91, 0x91, 0x6E}, //  8
{0x00, 0x70, 0x89, 0x89, 0x8A, 0x7C}, //  9
{0x00, 0x00, 0x00, 0xFD, 0x00, 0x00}, //  ! - out of ASCII sequence should be a :
{0x00, 0x44, 0x02, 0x12, 0x02, 0x44}, //  smile
{0x00, 0x08, 0x1C, 0x2A, 0x08, 0x08}, //  L arrow
{0x00, 0x14, 0x14, 0x14, 0x14, 0x14}, //  =
{0x00, 0x10, 0x10, 0x54, 0x38, 0x10}, //  R arrow
{0x00, 0x60, 0x80, 0x8D, 0x90, 0x60}, //  ?
{0x00, 0x66, 0x89, 0x8F, 0x81, 0x7E}, //  @
{0x00, 0x7F, 0x88, 0x88, 0x88, 0x7F}, //  A
{0x00, 0xFF, 0x91, 0x91, 0x91, 0x6E}, //  B
{0x00, 0x7E, 0x81, 0x81, 0x81, 0x42}, //  C
{0x00, 0xFF, 0x81, 0x81, 0x42, 0x3C}, //  D
{0x00, 0xFF, 0x91, 0x91, 0x91, 0x81}, //  E
{0x00, 0xFF, 0x90, 0x90, 0x90, 0x80}, //  F
{0x00, 0x7E, 0x81, 0x89, 0x89, 0x4E}, //  G
{0x00, 0xFF, 0x10, 0x10, 0x10, 0xFF}, //  H
{0x00, 0x81, 0x81, 0xFF, 0x81, 0x81}, //  I
{0x00, 0x06, 0x01, 0x01, 0x01, 0xFE}, //  J
{0x00, 0xFF, 0x18, 0x24, 0x42, 0x81}, //  K
{0x00, 0xFF, 0x01, 0x01, 0x01, 0x01}, //  L
{0x00, 0xFF, 0x40, 0x30, 0x40, 0xFF}, //  M
{0x00, 0xFF, 0x40, 0x30, 0x08, 0xFF}, //  N
{0x00, 0x7E, 0x81, 0x81, 0x81, 0x7E}, //  O
{0x00, 0xFF, 0x88, 0x88, 0x88, 0x70}, //  P
{0x00, 0x7E, 0x81, 0x85, 0x82, 0x7D}, //  Q
{0x00, 0xFF, 0x88, 0x8C, 0x8A, 0x71}, //  R
{0x00, 0x61, 0x91, 0x91, 0x91, 0x8E}, //  S
{0x00, 0x80, 0x80, 0xFF, 0x80, 0x80}, //  T
{0x00, 0xFE, 0x01, 0x01, 0x01, 0xFE}, //  U
{0x00, 0xF0, 0x0C, 0x03, 0x0C, 0xF0}, //  V
{0x00, 0xFF, 0x02, 0x0C, 0x02, 0xFF}, //  W
{0x00, 0xC3, 0x24, 0x18, 0x24, 0xC3}, //  X
{0x00, 0xE0, 0x10, 0x0F, 0x10, 0xE0}, //  Y
{0x00, 0x83, 0x85, 0x99, 0xA1, 0xC1}, //  Z
// gap missing 6 charactors
{0x00, 0x06, 0x29, 0x29, 0x29, 0x1F}, //  a
{0x00, 0xFF, 0x09, 0x11, 0x11, 0x0E}, //  b
{0x00, 0x1E, 0x21, 0x21, 0x21, 0x12}, //  c
{0x00, 0x0E, 0x11, 0x11, 0x09, 0xFF}, //  d
{0x00, 0x0E, 0x15, 0x15, 0x15, 0x0C}, //  e
{0x00, 0x08, 0x7F, 0x88, 0x80, 0x40}, //  f
{0x00, 0x30, 0x49, 0x49, 0x49, 0x7E}, //  g
{0x00, 0xFF, 0x08, 0x10, 0x10, 0x0F}, //  h
{0x00, 0x00, 0x00, 0x5F, 0x00, 0x00}, //  i
{0x00, 0x02, 0x01, 0x21, 0xBE, 0x00}, //  j
{0x00, 0xFF, 0x04, 0x0A, 0x11, 0x00}, //  k
{0x00, 0x00, 0x81, 0xFF, 0x01, 0x00}, //  l
{0x00, 0x3F, 0x20, 0x18, 0x20, 0x1F}, //  m
{0x00, 0x3F, 0x10, 0x20, 0x20, 0x1F}, //  n
{0x00, 0x0E, 0x11, 0x11, 0x11, 0x0E}, //  o
{0x00, 0x3F, 0x24, 0x24, 0x24, 0x18}, //  p
{0x00, 0x10, 0x28, 0x28, 0x18, 0x3F}, //  q
{0x00, 0x1F, 0x08, 0x10, 0x10, 0x08}, //  r
{0x00, 0x09, 0x15, 0x15, 0x15, 0x02}, //  s
{0x00, 0x20, 0xFE, 0x21, 0x01, 0x02}, //  t
{0x00, 0x1E, 0x01, 0x01, 0x02, 0x1F}, //  u
{0x00, 0x1C, 0x02, 0x01, 0x02, 0x1C}, //  v
{0x00, 0x1E, 0x01, 0x0E, 0x01, 0x1E}, //  w
{0x00, 0x11, 0x0A, 0x04, 0x0A, 0x11}, //  x
{0x00, 0x00, 0x39, 0x05, 0x05, 0x3E}, //  y
{0x00, 0x11, 0x13, 0x15, 0x19, 0x11} //  z
};