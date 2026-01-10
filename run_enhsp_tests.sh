#!/usr/bin/env bash

# Set Java memory options
export _JAVA_OPTIONS="-Xmx24g"

# Run tests with uv
# uv run test_enhsp_numeric.py
uv run test_enhsp_summon.py
uv run enhsp-plots.py
