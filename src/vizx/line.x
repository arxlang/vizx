```
title: Line charts
summary: Connects numeric coordinates in input order, without sorting.
```

import (Figure, dimensions, document) from .figure
import (Domain, paired, domain) from .scales
import axes from .axes
import (color, segment, circle) from .svg

fn line(x: list[f64], y: list[f64], title: str = "Line chart", width: i32 = 720, height: i32 = 460, color_index: i32 = 1) -> Figure:
  dimensions(width, height)
  var size: i32 = paired(x, y)
  var fill: str = color(color_index)
  var xd: Domain = domain(x)
  var yd: Domain = domain(y)
  var right: f64 = cast(width, f64) - 30.0
  var bottom: f64 = cast(height, f64) - 55.0
  var body: str = axes(xd, yd, right, bottom)
  var index: i32 = 0
  while index < size:
    var px: f64 = xd.map(x[index], 78.0, right)
    var py: f64 = yd.map(y[index], bottom, 70.0)
    if index > 0:
      body = body + segment(xd.map(x[index - 1], 78.0, right), yd.map(y[index - 1], bottom, 70.0), px, py, fill, 2.5)
    body = body + circle(px, py, 3.5, fill)
    index = index + 1
  return document(body, title, width, height)
