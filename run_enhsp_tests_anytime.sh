#!/usr/bin/env bash

# Set Java memory options
export _JAVA_OPTIONS="-Xmx24g"

# Run tests with uv
uv run test_enhsp_numeric.py --planners enhsp-any --output benchmark_results_numeric_anytime.json
uv run test_enhsp_summon.py --planners enhsp-any --output benchmark_results_summon_anytime.json