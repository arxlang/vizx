```
title: Shared SVG primitives
summary: Numeric geometry and built-in palette; no native extensions or JS.
```

import number from .numbers

fn color(index: i32) -> str:
  ```
  title: Validated palette color
  summary: Integer palette selection avoids injecting arbitrary SVG attributes.
  ```
  if index == 0:
    return "#2563eb"
  if index == 1:
    return "#c65d3b"
  if index == 2:
    return "#0d9488"
  if index == 3:
    return "#7c3aed"
  raise ValueError("vizx color must be a palette index from 0 to 3")

fn rect(x: f64, y: f64, width: f64, height: f64, fill: str) -> str:
  return "<rect x=\"" + number(x) + "\" y=\"" + number(y) + "\" width=\"" + number(width) + "\" height=\"" + number(height) + "\" fill=\"" + fill + "\"/>\n"

fn segment(x1: f64, y1: f64, x2: f64, y2: f64, stroke: str, width: f64 = 1.0) -> str:
  return "<line x1=\"" + number(x1) + "\" y1=\"" + number(y1) + "\" x2=\"" + number(x2) + "\" y2=\"" + number(y2) + "\" stroke=\"" + stroke + "\" stroke-width=\"" + number(width) + "\"/>\n"

fn circle(x: f64, y: f64, radius: f64, fill: str) -> str:
  return "<circle cx=\"" + number(x) + "\" cy=\"" + number(y) + "\" r=\"" + number(radius) + "\" fill=\"" + fill + "\"/>\n"

fn label(x: f64, y: f64, value: f64, anchor: str = "middle") -> str:
  return "<text x=\"" + number(x) + "\" y=\"" + number(y) + "\" text-anchor=\"" + anchor + "\" font-size=\"12\" fill=\"#64748b\">" + number(value) + "</text>\n"
