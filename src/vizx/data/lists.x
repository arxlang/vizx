```
title: Numeric list inputs
summary: Lossless widening of integer lists and range results into owned f64 lists.
```

fn from_i32_list(values: list[i32]) -> list[f64]:
  ```
  title: Snapshot an i32 list
  summary: All i32 values widen exactly to f64; the source is borrowed and unchanged.
  ```
  var result: list[f64]
  for value in values:
    result.append(cast(value, f64))
  return result
