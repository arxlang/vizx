# Vizx contributor guide

Vizx implementation, examples, and behavior tests are Arx source (`.x`).
Keep the implementation entirely in Arx. Do not introduce a Python, C/C++, JS,
Matplotlib, or Plotly renderer. Tooling used by Arx itself is not part of Vizx.

Use two-space indentation, typed arguments, and valid Douki module docstrings.
Treat Arx 1.25.0 compiled behavior as authoritative; syntax appearing in the
lexer does not establish usable language support.

Each chart owns its geometry in one module. Share validation, scales, axes,
numeric formatting, SVG primitives, and figure ownership. A new chart adds its
module, an explicit `express.x` export, focused tests, and an executable example;
it must not add chart-kind switches to existing renderers.

Reject invalid data before indexing. Preserve input order and caller ownership.
Do not silently drop nonfinite or mismatched points. Keep output deterministic,
and close output files even when writing fails.

Keep handwritten documentation to a quick start, architecture, and meaningful
restrictions; do not maintain a second API catalog. Put contracts beside code.

Run `makim tests.ci` and `arxpm pack` before submitting. When changing gallery
data or styling, regenerate the committed SVGs with `makim tests.gallery`.
PNG files are review previews of those SVGs, not a Vizx output backend.
