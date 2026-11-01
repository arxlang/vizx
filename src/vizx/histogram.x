```
title: Histogram charts
summary: Uniform numeric bins with count heights and an inclusive final edge.
```

import (Figure, dimensions, document) from .figure
import (Domain, domain) from .scales
import bin_counts from .bins
import axes from .axes
import (color, rect) from .svg

fn histogram(x: list[f64], nbins: i32 = 10, title: str = "Histogram", width: i32 = 720, height: i32 = 460, color_index: i32 = 3) -> Figure:
  ```
  title: Create a static count histogram
  summary: Constant samples receive an expanded domain; data and invalid bin counts fail before export.
  ```
  dimensions(width, height)
  var frequencies: list[f64] = bin_counts(x, nbins)
  var fill: str = color(color_index)
  var xd: Domain = domain(x)
  var yd: Domain = domain(frequencies, true)
  var right: f64 = cast(width, f64) - 30.0
  var bottom: f64 = cast(height, f64) - 55.0
  var body: str = axes(xd, yd, right, bottom)
  var slot: f64 = (right - 78.0) / cast(nbins, f64)
  var index: i32 = 0
  while index < nbins:
    var top: f64 = yd.map(frequencies[index], bottom, 70.0)
    body = body + rect(78.0 + cast(index, f64) * slot, top, slot, bottom - top, fill)
    index = index + 1
  return document(body, title, width, height)
