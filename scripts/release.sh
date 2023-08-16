#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $0 <schema version>"
    exit 1
fi
VERSION="$1"

# Check if schema file of given version exists
SCHEMA="docs/schemas/draft-$VERSION/schema.json"
SCHEMA_FINAL="docs/schemas/$VERSION/schema.json"
if [ ! -r "$SCHEMA" ]; then
    echo "Error: Input file $SCHEMA does not exist or is not readable."
    exit 1
fi

# Check if there are other files changed besides the schema
CHANGED_FILES=`git status --porcelain | grep -v "^.. $SCHEMA$"`
if [ -n  "$CHANGED_FILES" ]; then
    echo "Error: There are other files changed besides '$SCHEMA'."
    exit 1
fi

# Function to use sed with platform-specific -i flag
sed_inplace() {
    local file="$2"
    local expression="$1"

    if [ "$(uname)" = "Darwin" ]; then
        # macOS
        sed -i '' "$expression" "$file"
    else
        # Assume Linux
        sed -i "$expression" "$file"
    fi
}

set -e

# Load configuration
source .config
SCHEMA_URL="https://vodamiro.github.io/open-fuji-recipe/schemas/$VERSION/schema.json"

echo "Validating schema $SCHEMA against metaschema"
check-jsonschema  --no-cache --check-metaschema "$SCHEMA"

TO_TEST=`jq -r '.examples[0]["$schema"]' "$SCHEMA"`
if [ "$TO_TEST" != "$SCHEMA_URL" ]; then
    echo "Error: Schema URL of example does not match the final URL."
    exit 1
fi

TO_TEST=`jq -r '.properties["$schema"].enum | last' "$SCHEMA"`
if [ "$TO_TEST" != "$SCHEMA_URL" ]; then
    echo "Error: Last schema URL in enum does not match the final URL."
    exit 1
fi

TO_TEST=`jq -r '.["$id"]' "$SCHEMA"`
if [ "$TO_TEST" != "$SCHEMA_URL" ]; then
    echo "Error: Schema URL $SCHEMA_URL does not match the one inside the schema."
    exit 1
fi

TO_TEST=`jq -r '.properties["$schema"].default' "$SCHEMA"`
if [ "$TO_TEST" != "$SCHEMA_URL" ]; then
    echo "Error: Schema URL $SCHEMA_URL does not match the one inside the \$schema deafult value field."
    exit 1
fi

echo "Formatting schema…"
mv "$SCHEMA" "$SCHEMA".bak
jq --indent 4 . "$SCHEMA".bak > "$SCHEMA"
rm "$SCHEMA".bak

echo "Extracting example from schema to $EXAMPLE_JSON"
mkdir -p `dirname "$EXAMPLE_JSON"`
jq '.examples|.[0]' "$SCHEMA" > "$EXAMPLE_JSON"

echo "Validating example against schema…"
check-jsonschema --no-cache --schemafile "$SCHEMA" "$EXAMPLE_JSON"

echo "Copying $SCHEMA to $LATEST_SCHEMA"
rm -f "$LATEST_SCHEMA"
mkdir -p `dirname "$LATEST_SCHEMA"`
cp "$SCHEMA" "$LATEST_SCHEMA"

echo "Moving $SCHEMA to $SCHEMA_FINAL"
mkdir -p `dirname "$SCHEMA_FINAL"`
mv "$SCHEMA" "$SCHEMA_FINAL"

echo "Generating schema documentation…"
mkdir -p "$DOCS_DIR"
generate-schema-doc "$LATEST_SCHEMA" "$DOCS_DIR/index.html"

echo "Generating README from template…"
rm -f "$README"
cp "$TEMPLATE_TOP" "$README"
cat "$EXAMPLE_JSON" >> "$README"
cat "$TEMPLATE_BOTTOM" >> "$README"
sed_inplace "s|{{SCHEMA_VERSION}}|$VERSION|g" "$README"
sed_inplace "s|{{SCHEMA_URL}}|$SCHEMA_URL|g" "$README"
CAMERAS=`jq -r '.["$defs"].cameraModel.enum|join(", ")' $LATEST_SCHEMA`
sed_inplace "s|{{CAMERAS}}|$CAMERAS|g" "$README"

echo "✅ Done."
