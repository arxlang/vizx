```
title: Input adapter contracts
summary: Verifies direct column construction, exact integer widening, null rejection, and limits.
```

import from_i32_list from vizx.data.lists
import (from_series, from_nullable_series) from vizx.data.series

fn test_typed_input_adapters() -> none:
  var integers: list[i32] = range(1, 4)
  var widened: list[f64] = from_i32_list(integers)
  assert widened[0] == 1.0
  assert widened[2] == 3.0
  integers.append(4)
  var integer_count: i32 = 0
  for value in widened:
    integer_count = integer_count + 1
  assert integer_count == 3
  var frame: dataframe[x: f64, y: f64 | none] = dataframe({x: [0.0, 2.5, 7.0], y: [1.0, none, 3.0]})
  var snapshot: list[f64] = from_series(frame.x)
  assert snapshot[0] == 0.0
  assert snapshot[1] == 2.5
  assert frame.x[2] == 7.0
  var caught: bool = false
  try:
    from_series(frame.x, max_points=2)
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    from_nullable_series(frame.y)
  except ValueError:
    caught = true
  assert caught
  var complete: dataframe[x: f64 | none] = dataframe({x: [0.0, 2.0]})
  var complete_snapshot: list[f64] = from_nullable_series(complete.x)
  assert complete_snapshot[0] == 0.0
  assert complete_snapshot[1] == 2.0
  var empty: list[f64] = from_i32_list(range(0, 0))
  var empty_count: i32 = 0
  for value in empty:
    empty_count = empty_count + 1
  assert empty_count == 0
