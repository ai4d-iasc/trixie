# Trixie

## Documentation

Please see the [project wiki](https://ai4d-iasc.github.io/trixie/)

## Trixie Status

The current status of Trixie is available on the [status page](https://ai4d-iasc.github.io/trixie/Trixie-Status/)

## Issues

For new requests or problems with the machine, please check out the [issues section](https://github.com/ai4d-iasc/trixie/issues).
Please check to see if your issue has already been raised before submitting a new one (i.e. join the existing discussion).

## Contribute

### Setup

If you want to edit the documentation pages, create an `environment` and install `mkdocs` to test your pages.

```sh
uv --relocatable --python=3.11 --prompt=Trixie venv
source venv/bin/activate ""
uv pip install -r requirements.txt
```

### Validate your Documentation Locally

Start the server.

```sh
mkdocs serve
```

Open a browser to port 8000 on the machine you are editing the documentation to view the result.
