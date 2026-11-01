```
title: Pie charts
summary: Nonnegative slice weights, clockwise SVG sectors, and a numeric slice legend.
```

import (Figure, dimensions, document) from .figure
import count from .scales
import number from .numbers
import (color, circle) from .svg
import (sine, cosine) from .trigonometry

fn pie(values: list[f64], title: str = "Pie chart", width: i32 = 720, height: i32 = 460) -> Figure:
  ```
  title: Create a static pie figure
  summary: Accepts 1..12 nonnegative finite weights with positive total; zero weights keep their legend entry.
  ```
  dimensions(width, height)
  var size: i32 = count(values)
  if size < 1 || size > 12 || size * 24 > height - 90:
    raise ValueError("vizx pie requires 1..12 slices and enough height for the legend")
  var total: f64 = 0.0
  var positive: i32 = 0
  for value in values:
    if value < 0.0:
      raise ValueError("vizx pie weights must be nonnegative")
    if value > 0.0:
      positive = positive + 1
    total = total + value
  if total <= 0.0:
    raise ValueError("vizx pie weights must have a positive total")
  var cx: f64 = cast(width, f64) * 0.34
  var cy: f64 = (cast(height, f64) + 50.0) * 0.5
  var radius: f64 = cast(width, f64) * 0.27
  if radius > (cast(height, f64) - 130.0) * 0.5:
    radius = (cast(height, f64) - 130.0) * 0.5
  var body: str = "" + ""
  var angle: f64 = 0.0
  var index: i32 = 0
  var full_turn: f64 = 6.283185307179586
  while index < size:
    var weight: f64 = values[index]
    var fraction: f64 = weight / total
    var fill: str = color(index - (index / 4) * 4)
    if weight > 0.0:
      if positive == 1:
        body = body + circle(cx, cy, radius, fill)
      else:
        var next: f64 = angle + fraction * full_turn
        var large: str = "0"
        if fraction > 0.5:
          large = "1"
        var start_x: f64 = cx + radius * sine(angle)
        var start_y: f64 = cy - radius * cosine(angle)
        var end_x: f64 = cx + radius * sine(next)
        var end_y: f64 = cy - radius * cosine(next)
        body = body + "<path d=\"M " + number(cx) + " " + number(cy) + " L " + number(start_x) + " " + number(start_y) + " A " + number(radius) + " " + number(radius) + " 0 " + large + " 1 " + number(end_x) + " " + number(end_y) + " Z\" fill=\"" + fill + "\" stroke=\"white\" stroke-width=\"2\"/>\n"
        angle = next
    var legend_x: f64 = cast(width, f64) * 0.68
    var legend_y: f64 = 90.0 + cast(index, f64) * 24.0
    body = body + circle(legend_x, legend_y - 4.0, 5.0, fill)
    body = body + "<text x=\"" + number(legend_x + 14.0) + "\" y=\"" + number(legend_y) + "\" font-size=\"13\" fill=\"#334155\">" + number(cast(index + 1, f64)) + ": " + number(fraction * 100.0) + "%</text>\n"
    index = index + 1
  return document(body, title, width, height)
