```
title: Bar charts
summary: Numeric category labels in input order with a zero baseline.
```

import (Figure, dimensions, document) from .figure
import (Domain, paired, domain) from .scales
import axes from .axes
import (color, rect, segment, label) from .svg

fn bar(x: list[f64], y: list[f64], title: str = "Bar chart", width: i32 = 720, height: i32 = 460, color_index: i32 = 0) -> Figure:
  ```
  title: Create a static bar figure
  summary: Each x is a numeric category label; y may be positive, zero, or negative.
  ```
  dimensions(width, height)
  var size: i32 = paired(x, y)
  var fill: str = color(color_index)
  var yd: Domain = domain(y, true)
  var xd: Domain = Domain(0.0, cast(size, f64))
  var right: f64 = cast(width, f64) - 30.0
  var bottom: f64 = cast(height, f64) - 55.0
  var body: str = axes(xd, yd, right, bottom, false)
  var slot: f64 = (right - 78.0) / cast(size, f64)
  var baseline: f64 = yd.map(0.0, bottom, 70.0)
  body = body + segment(78.0, baseline, right, baseline, "#94a3b8")
  var index: i32 = 0
  while index < size:
    var top: f64 = yd.map(y[index], bottom, 70.0)
    var bar_height: f64 = baseline - top
    if top > baseline:
      bar_height = top - baseline
      top = baseline
    var left: f64 = 78.0 + cast(index, f64) * slot
    body = body + rect(left + slot * 0.17, top, slot * 0.66, bar_height, fill)
    if size <= 12:
      body = body + label(left + slot * 0.5, bottom + 25.0, x[index])
    index = index + 1
  return document(body, title, width, height)
