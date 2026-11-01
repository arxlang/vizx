```
title: Shared Cartesian axes
summary: Numeric ticks, horizontal grids, and a consistent plot viewport.
```

import Domain from .scales
import (segment, label) from .svg

fn axes(x: Domain, y: Domain, right: f64, bottom: f64, numeric_x: bool = true) -> str:
  var body: str = "" + ""
  var index: i32 = 0
  while index <= 4:
    var fraction: f64 = cast(index, f64) / 4.0
    var value: f64 = y.low + fraction * (y.high - y.low)
    var position: f64 = y.map(value, bottom, 70.0)
    body = body + segment(78.0, position, right, position, "#e2e8f0")
    body = body + label(66.0, position + 4.0, value, "end")
    if numeric_x:
      var tick: f64 = x.low + fraction * (x.high - x.low)
      body = body + label(x.map(tick, 78.0, right), bottom + 25.0, tick)
    index = index + 1
  body = body + segment(78.0, 70.0, 78.0, bottom, "#94a3b8")
  body = body + segment(78.0, bottom, right, bottom, "#94a3b8")
  return body
