```
title: SVG numeric formatting
summary: Locale-independent finite numbers with three fractional digits at most.
```

fn digit(value: i64) -> str:
  ```
  title: Decimal digit
  ```
  if value == 0:
    return "0"
  if value == 1:
    return "1"
  if value == 2:
    return "2"
  if value == 3:
    return "3"
  if value == 4:
    return "4"
  if value == 5:
    return "5"
  if value == 6:
    return "6"
  if value == 7:
    return "7"
  if value == 8:
    return "8"
  return "9"

fn integer(value: i64) -> str:
  ```
  title: Nonnegative integer text
  summary: Internal formatter for bounded nonnegative values.
  ```
  if value < 10:
    return digit(value)
  return integer(value / 10) + digit((value - (value / 10) * 10))

fn fixed(value: f64) -> str:
  ```
  title: Bounded nonnegative decimal text
  summary: Rounds to three decimal places and removes trailing fractional zeros.
  ```
  var scaled: i64 = cast(value * 1000.0 + 0.5, i64)
  var whole: i64 = scaled / 1000
  var fraction: i64 = (scaled - (scaled / 1000) * 1000)
  if fraction == 0:
    return integer(whole)
  var result: str = integer(whole) + "." + digit(fraction / 100)
  if (fraction - (fraction / 100) * 100) != 0:
    result = result + digit(((fraction / 10) - ((fraction / 10) / 10) * 10))
  if (fraction - (fraction / 10) * 10) != 0:
    result = result + digit((fraction - (fraction / 10) * 10))
  return result

fn number(value: f64) -> str:
  ```
  title: Finite SVG number
  summary: Uses scientific notation below 0.001 or at and above one million.
  ```
  if value == 0.0:
    return "0"
  if value < 0.0:
    return "-" + number(0.0 - value)
  if value >= 0.001 && value < 1000000.0:
    return fixed(value)
  var mantissa: f64 = value
  var exponent: i64 = 0
  while mantissa >= 10.0:
    mantissa = mantissa / 10.0
    exponent = exponent + 1
  while mantissa < 1.0:
    mantissa = mantissa * 10.0
    exponent = exponent - 1
  if exponent < 0:
    return fixed(mantissa) + "e-" + integer(0 - exponent)
  return fixed(mantissa) + "e" + integer(exponent)
