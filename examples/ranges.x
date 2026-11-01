```
title: Plot an integer range
summary: Demonstrates a loop-free numeric-list input without importing the Series adapter.
```

import histogram from vizx.express
import Figure from vizx.figure
import from_i32_list from vizx.data.lists

fn main() -> i32:
  var plot: Figure = histogram(from_i32_list(range(0, 20)), nbins=5, title="Integer range")
  plot.write_image("build/range-histogram.svg")
  return 0
