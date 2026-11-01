```
title: Arrow Series inputs
summary: Snapshot f64 Series and DataFrame columns without exposing Arrow layouts.
```

fn from_series(values: series[f64], max_points: i64 = 1000000) -> list[f64]:
  ```
  title: Snapshot a nonnullable Series
  summary: Copies in row order; rejects input beyond max_points before allocating the snapshot.
  ```
  var size: i64 = series_count(values)
  if max_points < 1 || size > max_points:
    raise ValueError("vizx Series exceeds max_points or the limit is invalid")
  var result: list[f64]
  var index: i64 = 0
  while index < size:
    result.append(values[index])
    index = index + 1
  return result

fn from_nullable_series(values: series[f64 | none], max_points: i64 = 1000000) -> list[f64]:
  ```
  title: Snapshot a nullable Series with strict null handling
  summary: Rejects any null instead of filtering rows and misaligning paired coordinates.
  ```
  var size: i64 = series_count(is_null(values))
  if max_points < 1 || size > max_points:
    raise ValueError("vizx Series exceeds max_points or the limit is invalid")
  var result: list[f64]
  var index: i64 = 0
  while index < size:
    var value: nullable[f64] = values[index]
    if is_null(value):
      raise ValueError("vizx coordinates must not contain null values")
    result.append(fill_null(value, 0.0))
    index = index + 1
  return result
