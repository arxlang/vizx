```
title: Shared numeric scales
summary: Validates finite nonempty paired data and maps domains into viewports.
```

class Domain:
  ```
  title: Numeric domain
  summary: Expands constant data and rejects values outside the safe SVG range.
  ```
  @[public, mutable]
  low: f64 = 0.0
  @[public, mutable]
  high: f64 = 1.0

  fn __init__(self, low: f64, high: f64) -> none:
    self.low = low
    self.high = high
    if low == high:
      var padding: f64 = 1.0
      if low > 1.0:
        padding = low * 0.05
      if low < (0.0 - 1.0):
        padding = (0.0 - low) * 0.05
      self.low = low - padding
      self.high = high + padding
    return none

  fn map(self, value: f64, start: f64, stop: f64) -> f64:
    return start + ((value - self.low) / (self.high - self.low)) * (stop - start)

fn count(values: list[f64]) -> i32:
  ```
  title: Count and validate numeric data
  summary: NaN, infinity, and magnitudes above 1e150 raise ValueError.
  ```
  var limit: f64 = 1.0
  for power in range(0, 15):
    limit = limit * 10000000000.0
  var size: i32 = 0
  for value in values:
    if !(value >= (0.0 - limit) && value <= limit):
      raise ValueError("vizx requires finite data with magnitude at most 1e150")
    size = size + 1
  return size

fn paired(x: list[f64], y: list[f64]) -> i32:
  ```
  title: Validate paired coordinates
  summary: Empty or unequal-length inputs raise ValueError before indexing.
  ```
  var size: i32 = count(x)
  if size == 0:
    raise ValueError("vizx requires at least one point")
  if size != count(y):
    raise ValueError("vizx requires x and y of equal length")
  return size

fn domain(values: list[f64], include_zero: bool = false) -> Domain:
  ```
  title: Derive an axis domain
  summary: Call paired first; include_zero gives bars their true zero baseline.
  ```
  var low: f64 = values[0]
  var high: f64 = values[0]
  for value in values:
    if value < low:
      low = value
    if value > high:
      high = value
  if include_zero:
    if low > 0.0:
      low = 0.0
    if high < 0.0:
      high = 0.0
  return Domain(low, high)
