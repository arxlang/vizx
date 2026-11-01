```
title: Bounded trigonometry for SVG geometry
summary: Pure-Arx sine and cosine for pie angles within zero to five pi over two.
```

fn sine(angle: f64) -> f64:
  ```
  title: Bounded sine approximation
  summary: Reduces the bounded pie angle to [-pi, pi] and evaluates twelve Taylor terms.
  ```
  var pi: f64 = 3.141592653589793
  var x: f64 = angle
  if x > pi:
    x = x - 2.0 * pi
  var term: f64 = x
  var result: f64 = x
  var index: i32 = 1
  while index < 12:
    var order: f64 = cast(2 * index, f64)
    term = (0.0 - term) * x * x / (order * (order + 1.0))
    result = result + term
    index = index + 1
  return result

fn cosine(angle: f64) -> f64:
  return sine(angle + 1.5707963267948966)
