```
title: Static figure and layout
summary: A figure owns completed SVG text; writes always close the file.
```

import number from .numbers

class Figure:
  ```
  title: Immutable static figure
  summary: Owns rendered text independently of the caller's coordinate lists.
  ```
  @[private, mutable]
  markup: str = ""

  fn __init__(self, markup: str) -> none:
    self.markup = markup
    return none

  fn to_svg(self) -> str:
    return self.markup

  fn write_image(self, path: str) -> none:
    ```
    title: Write an SVG image
    summary: The format is SVG regardless of extension; I/O failures propagate.
    ```
    var output: File = File(path, mode="w", encoding="utf-8")
    try:
      output.write(self.markup)
      output.flush()
    finally:
      output.close()
    return none

fn dimensions(width: i32, height: i32) -> none:
  if width < 320 || height < 240 || width > 4096 || height > 4096:
    raise ValueError("vizx dimensions must be 320..4096 by 240..4096 pixels")
  return none

fn document(body: str, title: str, width: i32, height: i32) -> Figure:
  ```
  title: Assemble a standalone SVG
  summary: Title is CDATA text and must not contain the CDATA terminator or XML control characters.
  ```
  var w: str = number(cast(width, f64))
  var h: str = number(cast(height, f64))
  var header: str = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"" + w + "\" height=\"" + h + "\" viewBox=\"0 0 " + w + " " + h + "\" role=\"img\">\n"
  var heading: str = "<title><![CDATA[" + title + "]]></title>\n<rect width=\"100%\" height=\"100%\" fill=\"#ffffff\"/>\n<g font-family=\"DejaVu Sans, sans-serif\">\n<text x=\"78\" y=\"38\" font-size=\"22\" font-weight=\"bold\" fill=\"#0f172a\"><![CDATA[" + title + "]]></text>\n"
  return Figure(header + heading + body + "</g>\n</svg>\n")
