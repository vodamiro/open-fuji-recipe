#!/bin/sh
source .config
echo "Cleaning…"
rm -f "$DOCS_DIR/index.html"
rm -f "$DOCS_DIR/schema_doc.css"
rm -f "$DOCS_DIR/schema_doc.min.js"
rm -f "$README"
rm -f "$EXAMPLE_JSON"
rm -f "$LATEST_SCHEMA"
echo "✅ Done."