```
title: Vizx static chart gallery
summary: Generates five SVG files using only Arx and the Vizx package.
```

import (bar, line, scatter, pie, histogram) from vizx.express
import Figure from vizx.figure
import from_series from vizx.data.series

fn main() -> i32:
  ```
  title: Generate the gallery
  summary: Run from the repository root after creating build and examples/output.
  ```
  var metrics: dataframe[month: f64, revenue: f64, growth: f64] = dataframe({
    month: [1.0, 2.0, 3.0, 4.0, 5.0, 6.0],
    revenue: [28.0, 45.0, 36.0, 62.0, 49.0, 74.0],
    growth: [12.0, 26.0, 21.0, 48.0, 44.0, 67.0],
  })
  var months: list[f64] = from_series(metrics.month)
  var revenue: list[f64] = from_series(metrics.revenue)
  var growth: list[f64] = from_series(metrics.growth)
  var bars: Figure = bar(months, revenue, title="Monthly revenue", color_index=0)
  bars.write_image("examples/output/bar.svg")
  var trend: Figure = line(months, growth, title="Community growth", color_index=1)
  trend.write_image("examples/output/line.svg")

  var samples: dataframe[effort: f64, outcome: f64] = dataframe({
    effort: [1.0, 1.5, 2.1, 2.7, 3.0, 3.8, 4.2, 4.8, 5.3, 5.9, 6.4, 7.0],
    outcome: [8.0, 16.0, 12.0, 26.0, 22.0, 39.0, 31.0, 46.0, 42.0, 57.0, 50.0, 65.0],
  })
  var effort: list[f64] = from_series(samples.effort)
  var outcome: list[f64] = from_series(samples.outcome)
  var points: Figure = scatter(effort, outcome, title="Effort & outcome", marker_size=6.0)
  points.write_image("examples/output/scatter.svg")

  var allocation: dataframe[weight: f64] = dataframe({weight: [42.0, 28.0, 18.0, 12.0]})
  var slices: Figure = pie(from_series(allocation.weight), title="Project allocation")
  slices.write_image("examples/output/pie.svg")
  var distribution: Figure = histogram(outcome, nbins=5, title="Outcome distribution")
  distribution.write_image("examples/output/histogram.svg")
  return 0
