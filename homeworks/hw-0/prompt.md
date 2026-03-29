I need to store keys and their translations in DB.

Keys has hierarchical structure that should be implemented in a way that allows easy import from YAML, export to YAML and search by full or partial path (like "root.branch_1.branch_2").

Each leaf key has multiple translations (one for each configured language). Translations can be of different types (text, boolean, array, plural, etc). But all translations for one key must have equal type.

Offer realization options.
