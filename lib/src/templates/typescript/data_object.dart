/// The template for data objects in typescript
const dataObjectTypescriptTemplate = '''
export interface {{name}} {
  {{#properties}}
  /** {{description}} */
  {{name}}{{#optional}}?{{/optional}}: {{type}};

  {{/properties}}
}
''';
