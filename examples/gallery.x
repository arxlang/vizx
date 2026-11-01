```
title: Vizx static chart gallery
summary: Generates three SVG files using only Arx and the Vizx package.
```

import (bar, line, scatter) from vizx.express
import Figure from vizx.figure

fn main() -> i32:
  ```
  title: Generate the gallery
  summary: Run from the repository root after creating build and examples/output.
  ```
  var months: list[f64]
  for value in [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]:
    months.append(value)
  var revenue: list[f64]
  for value in [28.0, 45.0, 36.0, 62.0, 49.0, 74.0]:
    revenue.append(value)
  var bars: Figure = bar(months, revenue, title="Monthly revenue", color_index=0)
  bars.write_image("examples/output/bar.svg")

  var growth: list[f64]
  for value in [12.0, 26.0, 21.0, 48.0, 44.0, 67.0]:
    growth.append(value)
  var trend: Figure = line(months, growth, title="Community growth", color_index=1)
  trend.write_image("examples/output/line.svg")

  var effort: list[f64]
  for value in [1.0, 1.5, 2.1, 2.7, 3.0, 3.8, 4.2, 4.8, 5.3, 5.9, 6.4, 7.0]:
    effort.append(value)
  var outcome: list[f64]
  for value in [8.0, 16.0, 12.0, 26.0, 22.0, 39.0, 31.0, 46.0, 42.0, 57.0, 50.0, 65.0]:
    outcome.append(value)
  var points: Figure = scatter(effort, outcome, title="Effort & outcome", marker_size=6.0)
  points.write_image("examples/output/scatter.svg")
  return 0
