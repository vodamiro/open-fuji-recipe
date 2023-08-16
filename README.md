# 📸 Open Fuji Recipe file standard
This repository contains specification of **Open Fuji Recipe (OFR)** file - a JSON file format designed to represent a film recipe for Fujifilm cameras, allowing users to easily share and transfer settings for achieving a specific film look. The goal of this open format is to facilitate interoperability among various photography tools and platforms.

This format aims to transform scattered and disparate forms of Fujifilm film recipe information — usually found in text or image format — into a structured, digital, and easily distributable format. By creating a universal standard for representing these recipes, we hope to promote a more seamless sharing experience and enhance the creative possibilities for photographers around the globe.

The file extension is **OFR**.

## 🌳 File Structure (Schema)
The file structure is defined by JSON schema. To support backward compatibility, the schema is versioned and the version will be increased in necessary cases.

Complete documentation of the schema can be found [HERE](https://vodamiro.github.io/open-fuji-recipe/).

Latest version of the file schema: `0.1`
URL of the schema: `https://vodamiro.github.io/open-fuji-recipe/schemas/0.1/schema.json`
Currently supported camera models: GFX_100, GFX_100S, GFX_50R, GFX_50S, GFX_50S_II, X-A1, X-A10, X-A2, X-A20, X-A3, X-A5, X-A7, X-E1, X-E2, X-E2S, X-E3, X-E4, X-H1, X-H2, X-H2S, X-M1, X-PRO1, X-PRO2, X-PRO3, X-S10, X-S20, X-T1, X-T10, X-T100, X-T2, X-T20, X-T200, X-T3, X-T30, X-T30_II, X-T4, X-T5, X100, X100F, X100S, X100T, X100V, X10, X20, X30, X70

### ☝️ Recommendations

**✅ Validation:** Always validate the JSON structure against the schema before sharing or after editing to ensure it's correctly formatted.
 
**🏷️ Versioning**: If you make enhancements or changes to the recipe format, consider versioning your files or indicating which schema version they comply with. This ensures backward compatibility and clarity for users.

### 🔍 Example

`My First Recipe.ofr`
```json
{
  "$schema": "https://vodamiro.github.io/open-fuji-recipe/schemas/0.1/schema.json",
  "settings": {
    "simulation": "CLASSIC_NEG",
    "whiteBalance": {
      "mode": "TEMPERATURE",
      "shift": {
        "r": 3,
        "b": -2
      },
      "temperature": 6500
    },
    "dynamicRange": "DR400",
    "toneCurve": {
      "highlights": 1.5,
      "shadows": -0.5
    },
    "color": 2,
    "sharpness": -1,
    "clarity": 0,
    "noiseReduction": -2,
    "effects": {
      "colorChrome": "STRONG",
      "colorChromeBlue": "STRONG",
      "grain": {
        "amount": "STRONG",
        "size": "LARGE"
      },
      "smoothSkin": "OFF"
    }
  },
  "meta": {
    "name": "My Classic Neg",
    "author": {
      "name": "Miroslav Voda",
      "links": [
        "https://github.com/vodamiro"
      ]
    },
    "links": [
      "https://example.com/my_classig_neg_recipe/"
    ],
    "publishedDate": "2023-07-30T22:20:00Z",
    "tags": [
      "fancy",
      "test"
    ],
    "camera": {
      "sensors": [
        "X_TRANS_IV",
        "X_TRANS_V_HR",
        "X_TRANS_V_HS"
      ],
      "models": [
        "X100V",
        "X-T5",
        "X-T4",
        "X-E4",
        "X-PRO3",
        "X-S10",
        "X-S20",
        "X-H2",
        "X-H2S"
      ]
    }
  }
}
```

## 🤗 Contribution

We wholeheartedly welcome any contributions to improve the Open Fujifilm Recipe file Format and its associated tools. Here's how you can help:

### 📣 Reporting Issues
If you find any problems or have suggestions about the open file format:

Check the issue tracker to see if your issue/suggestion has already been reported.
If not, open a new issue. Please provide a clear description of the problem or enhancement, and where applicable, add as much context as possible such as source, examples, and screenshots.