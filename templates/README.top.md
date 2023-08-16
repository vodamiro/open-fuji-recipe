# 📸 Open Fuji Recipe file standard
This repository contains specification of **Open Fuji Recipe (OFR)** file - a JSON file format designed to represent a film recipe for Fujifilm cameras, allowing users to easily share and transfer settings for achieving a specific film look. The goal of this open format is to facilitate interoperability among various photography tools and platforms.

This format aims to transform scattered and disparate forms of Fujifilm film recipe information — usually found in text or image format — into a structured, digital, and easily distributable format. By creating a universal standard for representing these recipes, we hope to promote a more seamless sharing experience and enhance the creative possibilities for photographers around the globe.

The file extension is **OFR**.

## 🌳 File Structure (Schema)
The file structure is defined by JSON schema. To support backward compatibility, the schema is versioned and the version will be increased in necessary cases.

Complete documentation of the schema can be found here:

Latest version of the file schema: `{{SCHEMA_VERSION}}`
URL of the schema: `{{SCHEMA_URL}}`
Currently supported camera models: {{CAMERAS}}

### ☝️ Recommendations

**✅ Validation:** Always validate the JSON structure against the schema before sharing or after editing to ensure it's correctly formatted.
 
**🏷️ Versioning**: If you make enhancements or changes to the recipe format, consider versioning your files or indicating which schema version they comply with. This ensures backward compatibility and clarity for users.

### 🔍 Example

`My First Recipe.ofr`
```json
