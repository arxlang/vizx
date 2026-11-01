```
title: Pie and histogram contracts
summary: Covers bin edges, negative samples, constants, slice validation, and geometry exports.
```

import (pie, histogram) from vizx.express
import Figure from vizx.figure
import bin_counts from vizx.bins
import from_i32_list from vizx.data.lists
import (sine, cosine) from vizx.trigonometry

fn test_uniform_bins() -> none:
  var samples: list[f64] = from_i32_list(range(0, 5))
  var frequencies: list[f64] = bin_counts(samples, 2)
  assert frequencies[0] == 2.0
  assert frequencies[1] == 3.0
  var plot: Figure = histogram(samples, nbins=2)
  plot.write_image("build/test-histogram.svg")
  var negative: list[f64] = from_i32_list(range(0 - 2, 3))
  var signed_counts: list[f64] = bin_counts(negative, 2)
  assert signed_counts[0] == 2.0
  assert signed_counts[1] == 3.0
  var constant: list[f64]
  constant.append(3.0)
  constant.append(3.0)
  var constant_counts: list[f64] = bin_counts(constant, 4)
  assert constant_counts[0] == 0.0
  assert constant_counts[2] == 2.0
  var degenerate: Figure = histogram(constant, nbins=4)
  degenerate.write_image("build/test-histogram-constant.svg")
  var caught: bool = false
  try:
    histogram(samples, nbins=0)
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    histogram(samples, nbins=129)
  except ValueError:
    caught = true
  assert caught
  var empty: list[f64]
  caught = false
  try:
    histogram(empty)
  except ValueError:
    caught = true
  assert caught

  var precision: list[f64]
  var first: f64 = 100000000000000000000.0
  var adjacent: f64 = 100000000000000016384.0
  precision.append(first)
  precision.append(adjacent)
  caught = false
  try:
    histogram(precision, nbins=128)
  except ValueError:
    caught = true
  assert caught

fn test_pie_weights_and_geometry() -> none:
  var weights: list[f64] = from_i32_list(range(1, 5))
  var plot: Figure = pie(weights)
  plot.write_image("build/test-pie.svg")
  var single: Figure = pie(from_i32_list(range(1, 2)))
  single.write_image("build/test-pie-single.svg")
  var zero_slice: Figure = pie(from_i32_list(range(0, 2)))
  zero_slice.write_image("build/test-pie-zero.svg")
  var dominant: list[f64]
  dominant.append(3.0)
  dominant.append(1.0)
  var large_arc: Figure = pie(dominant)
  large_arc.write_image("build/test-pie-large.svg")
  var caught: bool = false
  try:
    pie(from_i32_list(range(0, 1)))
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    pie(from_i32_list(range(0 - 1, 2)))
  except ValueError:
    caught = true
  assert caught
  caught = false
  try:
    pie(from_i32_list(range(0, 13)))
  except ValueError:
    caught = true
  assert caught
  var pi: f64 = 3.141592653589793
  var near_zero: f64 = sine(pi)
  assert near_zero > (0.0 - 0.0000001)
  assert near_zero < 0.0000001
  assert sine(pi * 0.5) > 0.9999999
  assert sine(pi * 1.5) < (0.0 - 0.9999999)
  assert cosine(pi * 2.0) > 0.9999999
