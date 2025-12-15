# Quick Test Script - Tests all problems with fastest configuration

$PLANNER = "..\cbp2\cbp-roller.exe"
$PROBLEMS_DIR = ".\"
$LOG_DIR = ".\test_logs"

# Create log directory
New-Item -ItemType Directory -Force -Path $LOG_DIR | Out-Null

$PROBLEMS = @(
    "problem-01.pddl", "problem-02.pddl", "problem-03.pddl", "problem-04.pddl",
    "problem-05.pddl", "problem-06.pddl", "problem-07.pddl", "problem-08.pddl",
    "problem-09.pddl", "problem-10.pddl"
)

Write-Host "`n=== Quick Satisficing Test ===" -ForegroundColor Cyan
Write-Host "Configuration: EHC + FF heuristic" -ForegroundColor Yellow
Write-Host "Logs will be saved to: $LOG_DIR`n" -ForegroundColor Gray

$failed = @()

foreach ($problem in $PROBLEMS) {
    Write-Host "Testing $problem..." -NoNewline
    
    $logFile = "$LOG_DIR\$($problem.Replace('.pddl', '.log'))"
    $output = & $PLANNER -p $PROBLEMS_DIR -o domain.pddl -f $problem -S 0 -H 0 -h 1.0 2>&1 | Tee-Object -FilePath $logFile
    $outputStr = $output -join "`n"
    
    if ($outputStr -match "found legal plan as follows") {
        if ($outputStr -match "total cost:\s+([\d.]+)") {
            $cost = $Matches[1]
            Write-Host " ✓ SOLVED (Cost: $cost)" -ForegroundColor Green
        } else {
            Write-Host " ✓ SOLVED" -ForegroundColor Green
        }
    }
    elseif ($outputStr -match "search space empty") {
        Write-Host " ✗ UNSOLVABLE (see $logFile)" -ForegroundColor Red
        $failed += $problem
    }
    elseif ($outputStr -match "Enforced Hill-climbing failed") {
        Write-Host " ✗ EHC FAILED (see $logFile)" -ForegroundColor Yellow
        $failed += $problem
    }
    else {
        Write-Host " ✗ FAILED (see $logFile)" -ForegroundColor Red
        $failed += $problem
    }
}

if ($failed.Count -gt 0) {
    Write-Host "`nFailed problems:" -ForegroundColor Red
    $failed | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
    Write-Host "`nCheck logs in: $LOG_DIR" -ForegroundColor Gray
}

Write-Host "`nTest complete! ($($PROBLEMS.Count - $failed.Count)/$($PROBLEMS.Count) solved)`n" -ForegroundColor Cyan