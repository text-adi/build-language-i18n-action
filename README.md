# Building i18n files

Building translation files for the i18n library
 

## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Upload Website

on:
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: docker://textadi/build-language-i18n-action@v2
      env:
        DIR: src
```

You can also use an image from the repository. 
To do this, specify `textadi/build-language-i18n-action@v2.0` instead of `docker://textadi/build-language-i18n-action@v2`

### Configuration

The following settings must be passed as environment variables as shown in the example. Sensitive information, especially `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) — otherwise, they'll be public to anyone browsing your repository's source code and CI logs.

| Key | Value                                                                                             | Suggested Type | Required | Default               |
| ------------- |---------------------------------------------------------------------------------------------------| ------------- | ------------- |-----------------------|
| `DEST_DIR` | Directory for build language files For example, `src`. Defaults to the root of the bucket. | `env` | No | `./` (root of bucket) |
