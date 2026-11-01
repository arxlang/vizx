```
title: Numeric formatting tests
summary: Exercises decimal rounding, zero trimming, signs, and scientific values.
```

import (integer, number) from vizx.numbers

fn test_numeric_formatting() -> none:
  assert integer(1209) == "1209"
  assert number(0.0) == "0"
  assert number(12.0) == "12"
  assert number(0.125) == "0.125"
  assert number(1.01) == "1.01"
  assert number(1.005) == "1.005"
  assert number(1.9999) == "2"
  assert number(0.0 - 2.5) == "-2.5"
  assert number(10000000.0) == "1e7"
  assert number(0.00001) == "1e-5"
