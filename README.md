# Building i18n files

Building translation files for the i18n library
 

## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Build Files

on:
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: docker://textadi/build-language-i18n-action@v3
      env:
        DIR: src
```

You can also use an image from the repository. 
To do this, specify `textadi/build-language-i18n-action@v3` instead of `docker://textadi/build-language-i18n-action@v2`

### Configuration

| Key | Value                                                                                             | Suggested Type | Required | Default               |
| ------------- |---------------------------------------------------------------------------------------------------| ------------- | ------------- |-----------------------|
| `DIR` | Directory for build language files For example, `src`. Defaults to the root of the bucket. | `env` | No | `./` (root of bucket) |
