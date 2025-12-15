# ============================================================
# Dark Souls PDDL - Experiment Battery Script
# ============================================================
# Tests multiple planners and heuristics on all problems
# Author: Victor Ramos Osuna
# ============================================================

# Configuration
$PLANNER = "..\cbp2\cbp-roller.exe"
$DOMAIN = ".\domain.pddl"
$PROBLEMS_DIR = ".\"
$RESULTS_DIR = ".\results"
$TIMESTAMP = Get-Date -Format "yyyyMMdd_HHmmss"
$EXPERIMENT_DIR = "$RESULTS_DIR\exp_$TIMESTAMP"

# Create results directory
New-Item -ItemType Directory -Force -Path $EXPERIMENT_DIR | Out-Null
New-Item -ItemType Directory -Force -Path "$EXPERIMENT_DIR\logs" | Out-Null

# Problem files
$PROBLEMS = @(
    "problem-01.pddl",
    "problem-02.pddl",
    "problem-03.pddl",
    "problem-04.pddl",
    "problem-05.pddl",
    "problem-06.pddl",
    "problem-07.pddl",
    "problem-08.pddl",
    "problem-09.pddl",
    "problem-10.pddl"
)

# Search algorithms to test
$SEARCH_ALGORITHMS = @(
    @{ID=0; Name="EHC-FF"; Desc="Enforced Hill-Climbing (fastest for satisficing)"},
    @{ID=1; Name="BFS-FF"; Desc="Best-first Search (more robust)"},
    @{ID=2; Name="CEHC"; Desc="Cost-aware EHC"},
    @{ID=11; Name="ModHC"; Desc="Modified Hill-Climbing"}
)

# Heuristics to test
$HEURISTICS = @(
    @{ID=0; Name="FF"; Desc="Metric-FF"},
    @{ID=3; Name="hmax"; Desc="hmax heuristic"},
    @{ID=4; Name="hadd"; Desc="hadd heuristic"},
    @{ID=5; Name="hadd-help"; Desc="hadd with helpful actions"},
    @{ID=6; Name="hmax-help"; Desc="hmax with helpful actions"}
)

# Configurations for satisficing search
$SAT_CONFIGS = @(
    @{Search=0; Heuristic=0; gWeight=0.0; hWeight=1.0; Name="EHC-FF-Sat"},
    @{Search=0; Heuristic=5; gWeight=0.0; hWeight=1.0; Name="EHC-hadd-help-Sat"},
    @{Search=1; Heuristic=0; gWeight=0.0; hWeight=1.0; Name="BFS-FF-Sat"},
    @{Search=1; Heuristic=5; gWeight=0.0; hWeight=1.0; Name="BFS-hadd-help-Sat"}
)

# Configurations for optimal search
$OPT_CONFIGS = @(
    @{Search=2; Heuristic=0; gWeight=1.0; hWeight=3.0; Name="CEHC-FF-Opt"},
    @{Search=2; Heuristic=4; gWeight=1.0; hWeight=3.0; Name="CEHC-hadd-Opt"},
    @{Search=1; Heuristic=4; gWeight=1.0; hWeight=1.0; Name="BFS-hadd-Opt"}
)

# Initialize summary file
$SUMMARY_FILE = "$EXPERIMENT_DIR\summary.csv"
"Problem,Configuration,Search,Heuristic,Optimal,Status,Time(s),Cost,StatesEvaluated,PlanLength" | Out-File -FilePath $SUMMARY_FILE

# Color functions
function Write-Header {
    param($Text)
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host $Text -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
}

function Write-Success {
    param($Text)
    Write-Host "✓ $Text" -ForegroundColor Green
}

function Write-Error {
    param($Text)
    Write-Host "✗ $Text" -ForegroundColor Red
}

function Write-Info {
    param($Text)
    Write-Host "→ $Text" -ForegroundColor Yellow
}

# Run a single experiment
function Run-Experiment {
    param(
        $Problem,
        $Config,
        $IsOptimal
    )
    
    $problemName = [System.IO.Path]::GetFileNameWithoutExtension($Problem)
    $configName = $Config.Name
    $logFile = "$EXPERIMENT_DIR\logs\${problemName}_${configName}.log"
    
    Write-Info "Testing: $problemName with $configName"
    
    # Build command
    $args = @(
        "-p", $PROBLEMS_DIR,
        "-o", "domain.pddl",
        "-f", $Problem,
        "-S", $Config.Search,
        "-H", $Config.Heuristic,
        "-g", $Config.gWeight,
        "-h", $Config.hWeight
    )
    
    if ($IsOptimal) {
        $args += "-O"
    }
    
    # Run planner and capture output
    $startTime = Get-Date
    try {
        $output = & $PLANNER $args 2>&1 | Tee-Object -FilePath $logFile
        $endTime = Get-Date
        $duration = ($endTime - $startTime).TotalSeconds
        
        # Parse results
        $status = "UNKNOWN"
        $cost = -1
        $statesEvaluated = 0
        $planLength = 0
        
        $outputStr = $output -join "`n"
        
        if ($outputStr -match "search space empty") {
            $status = "UNSOLVABLE"
            Write-Error "Unsolvable"
        }
        elseif ($outputStr -match "found legal plan as follows") {
            $status = "SOLVED"
            
            # Extract cost
            if ($outputStr -match "total cost:\s+([\d.]+)") {
                $cost = [double]$Matches[1]
            }
            
            # Extract states evaluated
            if ($outputStr -match "evaluating\s+(\d+)\s+states") {
                $statesEvaluated = [int]$Matches[1]
            }
            
            # Count plan steps
            $planSteps = ($outputStr -split "`n" | Where-Object { $_ -match "^\d+:" }).Count
            $planLength = $planSteps
            
            Write-Success "Solved - Cost: $cost, Time: $([math]::Round($duration, 2))s, States: $statesEvaluated"
        }
        elseif ($outputStr -match "Enforced Hill-climbing failed") {
            $status = "EHC_FAILED"
            Write-Error "EHC Failed (switching to BFS)"
        }
        else {
            $status = "ERROR"
            Write-Error "Unknown error"
        }
        
        # Save to summary
        $optimality = if ($IsOptimal) { "Yes" } else { "No" }
        "$problemName,$configName,$($Config.Search),$($Config.Heuristic),$optimality,$status,$([math]::Round($duration, 2)),$cost,$statesEvaluated,$planLength" | 
            Out-File -FilePath $SUMMARY_FILE -Append
        
    }
    catch {
        Write-Error "Failed to run: $_"
        "$problemName,$configName,$($Config.Search),$($Config.Heuristic),ERROR,0,-1,0,0" | 
            Out-File -FilePath $SUMMARY_FILE -Append
    }
}

# Main execution
Write-Header "Dark Souls PDDL - Experiment Battery"
Write-Host "Experiment Directory: $EXPERIMENT_DIR" -ForegroundColor White
Write-Host "Total Problems: $($PROBLEMS.Count)" -ForegroundColor White
Write-Host "Satisficing Configs: $($SAT_CONFIGS.Count)" -ForegroundColor White
Write-Host "Optimal Configs: $($OPT_CONFIGS.Count)" -ForegroundColor White
Write-Host ""

$totalExperiments = $PROBLEMS.Count * ($SAT_CONFIGS.Count + $OPT_CONFIGS.Count)
$currentExperiment = 0

# Run satisficing experiments
Write-Header "SATISFICING SEARCH EXPERIMENTS"
foreach ($problem in $PROBLEMS) {
    Write-Host "`n--- Problem: $problem ---" -ForegroundColor Magenta
    foreach ($config in $SAT_CONFIGS) {
        $currentExperiment++
        Write-Host "[$currentExperiment/$totalExperiments] " -NoNewline -ForegroundColor Gray
        Run-Experiment -Problem $problem -Config $config -IsOptimal $false
    }
}

# Run optimal experiments
Write-Header "OPTIMAL SEARCH EXPERIMENTS"
foreach ($problem in $PROBLEMS) {
    Write-Host "`n--- Problem: $problem ---" -ForegroundColor Magenta
    foreach ($config in $OPT_CONFIGS) {
        $currentExperiment++
        Write-Host "[$currentExperiment/$totalExperiments] " -NoNewline -ForegroundColor Gray
        Run-Experiment -Problem $problem -Config $config -IsOptimal $true
    }
}

# Generate analysis
Write-Header "GENERATING ANALYSIS"

$analysis = @"
# Dark Souls PDDL - Experiment Results
Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Configuration Summary
- Total Problems Tested: $($PROBLEMS.Count)
- Satisficing Configurations: $($SAT_CONFIGS.Count)
- Optimal Configurations: $($OPT_CONFIGS.Count)
- Total Experiments: $totalExperiments

## Results Summary
See summary.csv for detailed results.

### Quick Stats
"@

# Read summary and generate stats
$results = Import-Csv $SUMMARY_FILE
$solved = ($results | Where-Object { $_.Status -eq "SOLVED" }).Count
$unsolvable = ($results | Where-Object { $_.Status -eq "UNSOLVABLE" }).Count
$failed = ($results | Where-Object { $_.Status -ne "SOLVED" -and $_.Status -ne "UNSOLVABLE" }).Count

$analysis += @"

- Solved: $solved / $totalExperiments ($([math]::Round(100.0 * $solved / $totalExperiments, 1))%)
- Unsolvable: $unsolvable / $totalExperiments ($([math]::Round(100.0 * $unsolvable / $totalExperiments, 1))%)
- Failed: $failed / $totalExperiments ($([math]::Round(100.0 * $failed / $totalExperiments, 1))%)

## Best Configurations

### Fastest Solving (Satisficing)
"@

# Find best configurations
$solvedResults = $results | Where-Object { $_.Status -eq "SOLVED" }
if ($solvedResults.Count -gt 0) {
    $fastestSat = $solvedResults | Where-Object { $_.Optimal -eq "No" } | Sort-Object { [double]$_.'Time(s)' } | Select-Object -First 3
    foreach ($r in $fastestSat) {
        $analysis += "`n- $($r.Configuration) on $($r.Problem): $($r.'Time(s)')s, Cost: $($r.Cost)"
    }
    
    $analysis += "`n`n### Best Quality (Optimal)`n"
    $bestOpt = $solvedResults | Where-Object { $_.Optimal -eq "Yes" } | Sort-Object { [double]$_.Cost } | Select-Object -First 3
    foreach ($r in $bestOpt) {
        $analysis += "`n- $($r.Configuration) on $($r.Problem): Cost: $($r.Cost), Time: $($r.'Time(s)')s"
    }
}

$analysis | Out-File -FilePath "$EXPERIMENT_DIR\analysis.md"

Write-Success "`nExperiments completed!"
Write-Host "Results saved to: $EXPERIMENT_DIR" -ForegroundColor White
Write-Host "Summary: $SUMMARY_FILE" -ForegroundColor White
Write-Host "Analysis: $EXPERIMENT_DIR\analysis.md" -ForegroundColor White

# Open summary in default CSV viewer
Write-Info "`nOpening summary..."
Start-Process $SUMMARY_FILE