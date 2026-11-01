```
title: Chart integration tests
summary: Exercises all Express entry points, snapshots, ownership, and file I/O.
```

import (bar, line, scatter) from vizx.express
import (Figure, document) from vizx.figure
import (rect, circle) from vizx.svg

fn test_primitives_and_chart_exports() -> none:
  assert rect(1.0, 2.0, 3.0, 4.0, "#2563eb") == "<rect x=\"1\" y=\"2\" width=\"3\" height=\"4\" fill=\"#2563eb\"/>\n"
  assert circle(10.0, 20.0, 5.0, "#0d9488") == "<circle cx=\"10\" cy=\"20\" r=\"5\" fill=\"#0d9488\"/>\n"
  var x: list[f64]
  var y: list[f64]
  x.append(1.0)
  x.append(2.0)
  y.append(0.0 - 3.0)
  y.append(5.0)
  var bars: Figure = bar(x, y, title="Mixed signs < & >", width=640, height=400)
  var trend: Figure = line(x, y)
  var points: Figure = scatter(x, y)
  var snapshot: str = bars.to_svg()
  y.append(99.0)
  assert bars.to_svg() == snapshot
  bars.write_image("build/test-bar.svg")
  trend.write_image("build/test-line.svg")
  points.write_image("build/test-scatter.svg")
  var source: File = File("build/test-bar.svg")
  assert source.read() == snapshot
  source.close()
  var alias: Figure = bars
  assert alias.to_svg() == snapshot
  var empty: Figure = document("", "Empty", 640, 400)
  empty.write_image("build/test-empty.svg")

fn test_options_and_degenerate_data() -> none:
  var x: list[f64]
  var y: list[f64]
  x.append(2.0)
  y.append(0.0)
  var single: Figure = line(x, y)
  single.write_image("build/test-single.svg")
  var zero: Figure = bar(x, y)
  zero.write_image("build/test-zero.svg")
  x.append(2.0)
  y.append(0.0)
  var constant: Figure = scatter(x, y)
  constant.write_image("build/test-constant.svg")
  var caught: bool = false
  try:
    scatter(x, y, marker_size=0.0)
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    bar(x, y, color_index=4)
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    line(x, y, width=20)
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    constant.write_image("build/missing-directory/chart.svg")
  except OSError:
    caught = true
  assert caught
