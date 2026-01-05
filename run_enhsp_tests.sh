#!/usr/bin/env bash

# Set Java memory options
export _JAVA_OPTIONS="-Xmx16g"

# Run tests with uv
uv run test_enhsp_numeric.py
uv run test_enhsp_summon.py
