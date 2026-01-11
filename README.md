Dark Souls Automated Planning Project
====================================

This repository contains a set of PDDL domains and Python tooling that model a simplified Dark Souls–style game for automated planning experiments. It includes:

- Numeric PDDL domains (health, souls, Estus, etc.)
- A propositional / compiled domain for Fast Downward (no numeric fluents)
- An extended numeric domain with summons/minions
- Scripts to benchmark ENHSP-based planners via unified
	planning
- Utilities to visualize PDDL problems as graphs


Project Structure
-----------------

- darksouls/ – Numeric Dark Souls domain and benchmark problems.
- darksouls-fd/ – Propositional (Fast Downward–compatible) domain and problems.
- darksouls-invocations/ – Numeric domain with summons/minions and problems.
- plans-numeric/ – Saved plans for numeric benchmarks.
- plans-summon/ – Saved plans for summon benchmarks.
- plots/ – Generated plots and analysis artifacts.
- test_enhsp_numeric.py – ENHSP numeric benchmark driver.
- test_enhsp_summon.py – ENHSP summon/invocation benchmark driver.
- visualize_problem.py – PDDL problem visualizer (network graph + Plotly).
- main.py – Entry point for custom experiments (if used).
- pyproject.toml – Python project and dependency metadata.


Prerequisites
-------------

- Python 3.12+ (as specified in pyproject.toml, recommended via Conda or virtualenv)
- ENHSP installed and available to unified_planning (or via its engines)
- Fast Downward (optional, for the darksouls-fd domain)

Install Python dependencies (using pip):

```bash
pip install -e .
```

or, if you prefer plain install without editable mode:

```bash
pip install .
```


If you use uv (recommended for this project), you can also run scripts like:

```bash
uv run test_enhsp_numeric.py
uv run test_enhsp_summon.py
uv run enhsp-plots.py
```
which will create and manage a virtual environment automatically based on pyproject.toml.


Running Numeric Benchmarks
--------------------------

The numeric Dark Souls domain (no summons) lives in darksouls/. To benchmark ENHSP variants on the benchmark problems:

```bash
python test_enhsp_numeric.py
```

or with uv (no manual venv needed):

```bash
uv run test_enhsp_numeric.py
```

By default this uses:

- Domain: darksouls/domain.pddl
- Problems: darksouls/problem-bench-*.pddl
- Planners: enhsp, enhsp-opt, enhsp-any
- Output JSON: benchmark_results_numeric.json
- Plans directory: plans-numeric/

Useful options:

- `--domain PATH` – Override domain PDDL file.
- `--problem-dir DIR` – Directory containing problem files.
- `--problem-glob PATTERN` – Glob to discover problem files.
- `--problems FILE1 FILE2 ...` – Explicit list of problem files (relative to problem dir).
- `--limit N` – Maximum number of problems to run (0 = no limit).
- `--planners NAMES...` – Subset of planners (e.g. enhsp enhsp-opt).
- `--timeout SECONDS` – Timeout for non-optimal planners.
- `--timeout-opt SECONDS` – Timeout for optimal planners (name contains "opt").
- `--output FILE` – JSON output file.
- `--plan-dir DIR` – Where to store generated plans.


Running Summon/Invocation Benchmarks
------------------------------------

The extended domain with summons/minions is in darksouls-invocations/. To benchmark it:

```bash
python test_enhsp_summon.py
```

or with uv:

```bash
uv run test_enhsp_summon.py
```

Defaults:

- Domain: darksouls-invocations/domain.pddl
- Problems: darksouls-invocations/problem-bench-*.pddl
- Output JSON: benchmark_results_summon.json
- Plans directory: plans-summon/

The CLI options are the same as for test_enhsp_numeric.py.


Fast Downward Experiments (Propositional Domain)
-----------------------------------------------

The directory darksouls-fd/ contains a propositional compilation of the Dark Souls domain suitable for Fast Downward. Problems are named similarly to the numeric ones (problem-bench-*.pddl, etc.).

Use the helper script run_fast_downward.sh as a starting point for experiments. Example (from the project root):

```bash
bash run_fast_downward.sh
```

You can adapt the script to test different Fast Downward configurations and heuristics.


Provided Helper Executables
---------------------------

- run_enhsp_tests.sh
	- Bash helper that runs the full ENHSP-based experiment suite via uv:
		- `uv run test_enhsp_numeric.py`
		- `uv run test_enhsp_summon.py`
		- `uv run enhsp-plots.py`
	- From the project root on a Unix-like shell (Linux, WSL, macOS):

		```bash
		bash run_enhsp_tests.sh
		```

- run_fast_downward.sh
	- Automates Fast Downward experiments over the propositional domain in darksouls-fd/.
	- Requires FAST_DOWNWARD_PATH in the script to point to your Fast Downward checkout.
	- From the project root:

		```bash
		bash run_fast_downward.sh
		```


Visualizing PDDL Problems
-------------------------

The script visualize_problem.py turns a PDDL problem into an interactive Plotly graph (locations, edges, enemies, keys, titanite, bonfires, etc.). Example:

```bash
python visualize_problem.py --problem_file darksouls/problem-bench-01.pddl -o problem-bench-01.html
```

If `-o` is omitted, an interactive Plotly window will be opened. For best results, use an .html output and open it in a browser.


Benchmark Outputs
-----------------

- benchmark_results_numeric.json – Summary of numeric benchmarks.
- benchmark_results_summon.json – Summary of summon benchmarks.

Each entry typically includes:

- Problem name
- Planner name and status
- Time, plan length, cost (metric)
- Search statistics (nodes, dead ends, etc., when available)

Plans produced by planners are saved under plans-numeric/ and plans-summon/ with filenames of the form:

- `problem-bench-01__ENHSP.plan`


Reproducibility Tips
--------------------

- Ensure ENHSP and Fast Downward are installed in your PATH or configured as expected by unified_planning.
- Use a dedicated conda environment to avoid package version conflicts.
- Keep benchmark scripts and problem sets unchanged when comparing planners or settings.

Authors 
-------------------
- Emanuel Pacheco 
- Víctor Ramos 

License and Credits
-------------------

This project is for academic / educational experimentation with automated planning in a Dark Souls–inspired setting.
