module.exports = {
  "parser": "babel-eslint",
  "extends": "airbnb",
  "plugins": [
    "flowtype",
    "graphql"
  ],
  "env": {
    "browser": true
  },
  "rules": {
    "class-methods-use-this": [
      "error",
      {
        "exceptMethods": [
          "componentDidCatch",
          "render"
        ]
      }
    ],
    "function-paren-newline": ["error", "consistent"],
    "graphql/template-strings": ["error", {
      env: "literal",
      schemaJson: require("./schema.json")
    }],
    "import/extensions": ["error", "never"],
    "max-len": ["error", 120],
    "no-param-reassign": ["off"],
    "no-plusplus": ["off"],
    "no-underscore-dangle": ["error", {"allowAfterThis": true}],
    "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "yoda": ["error", "always"],
    "flowtype/boolean-style": [
      2,
      "boolean"
    ],
    "flowtype/define-flow-type": 1,
    "flowtype/delimiter-dangle": [
      2,
      "only-multiline"
    ],
    "flowtype/generic-spacing": [
      2,
      "never"
    ],
    "flowtype/no-primitive-constructor-types": 2,
    "flowtype/no-types-missing-file-annotation": 2,
    "flowtype/no-weak-types": 2,
    "flowtype/object-type-delimiter": [
      2,
      "comma"
    ],
    "flowtype/require-parameter-type": 2,
    "flowtype/require-return-type": [
      2,
      "always",
      {
        "annotateUndefined": "never",
        "excludeArrowFunctions": true
      }
    ],
    "flowtype/require-valid-file-annotation": 2,
    "flowtype/semi": [
      2,
      "always"
    ],
    "flowtype/space-after-type-colon": [
      2,
      "always"
    ],
    "flowtype/space-before-generic-bracket": [
      2,
      "never"
    ],
    "flowtype/space-before-type-colon": [
      2,
      "never"
    ],
    "flowtype/union-intersection-spacing": [
      2,
      "always"
    ],
    "flowtype/use-flow-type": 1,
    "flowtype/valid-syntax": 1,
    "import/prefer-default-export": ["off"]
  },
  "settings": {
    "flowtype": {
      "onlyFilesWithFlowAnnotation": false
    },
    "import/resolver": {
      "node": {
        "paths": ["app/javascript"],
        "extensions": [".js", ".jsx", ".graphql"]
      }
    }
  }
}
