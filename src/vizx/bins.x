```
title: Uniform histogram binning
summary: Left-closed bins; only the final bin also includes its right edge.
```

import (Domain, count, domain) from .scales

fn bin_counts(values: list[f64], nbins: i32) -> list[f64]:
  ```
  title: Count uniform bins
  summary: Validates finite nonempty input, 1..128 bins, and representable distinct bin edges.
  ```
  if nbins < 1 || nbins > 128:
    raise ValueError("vizx nbins must be from 1 to 128")
  if count(values) == 0:
    raise ValueError("vizx histogram requires at least one value")
  var extent: Domain = domain(values)
  var step: f64 = (extent.high - extent.low) / cast(nbins, f64)
  var result: list[f64]
  var index: i32 = 0
  while index < nbins:
    var left: f64 = extent.low + cast(index, f64) * step
    var right: f64 = extent.low + cast(index + 1, f64) * step
    if index == nbins - 1:
      right = extent.high
    if right <= left:
      raise ValueError("vizx nbins exceeds the numeric precision of the data range")
    var frequency: i32 = 0
    for value in values:
      if value >= left && (value < right || (index == nbins - 1 && value <= right)):
        frequency = frequency + 1
    result.append(cast(frequency, f64))
    index = index + 1
  return result
