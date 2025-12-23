# --- CONFIGURATION ---
$plannerPath = "..\cbp2\cbp-roller.exe"
$problemDir = ".\darksouls\"
$domainFile = "domain.pddl"
$resultsFile = "benchmark_summary.csv"
$rawLogFile = "benchmark_raw.log"

$configs = @(
    @{ name = "Metric-FF-EHC";  args = @("-H", "0", "-S", "0") },
    @{ name = "CEHC-Cost";      args = @("-H", "0", "-S", "19", "-O") },
    @{ name = "Anytime-BFS";    args = @("-H", "0", "-S", "1", "-O", "-n") },
    @{ name = "Hadd-Metric";    args = @("-H", "4", "-S", "1", "-O") }
)

# Cost mapping from domain.pddl 
$costTable = @{
    "MOVE"              = 10
    "FLEE-BOSS"         = 20
    "UPGRADE-WEAPON"    = 50
    "KILL-BOSS"         = 100
    "PICK-UP-KEY"       = 5
    "UNLOCK-DOOR"       = 10
    "OPEN-SHORTCUT"     = 15
    "ATTACK"            = 5
    "EXECUTE-ENEMY"     = 2
    "PICK-UP-TITANITE"  = 5
    "DRINK-ESTUS"       = 5
    "REST"              = 60
    "LEVEL-UP-STATS"    = 10
    "DEPOSIT-SOUL"      = 10
    "RESPAWN"           = 200
}

"Problem,Config,Solved,TotalCost,PlanLength,StatesEval,SearchTime" | Out-File $resultsFile -Encoding utf8

foreach ($i in 1..10) {
    $probNum = $i.ToString("00")
    $probFile = "problem-bench-$probNum.pddl"
    
    foreach ($cfg in $configs) {
        $cfgName = $cfg.name
        $allArgs = @("-p", $problemDir, "-o", $domainFile, "-f", $probFile) + $cfg.args
        $output = & $plannerPath $allArgs 2>&1 | Out-String
        
        $output | Out-File $rawLogFile -Append

        # 1. Check if solved if found legal plan appears or total cost
        $isSolved = if ($output -match "found legal plan" -or $output -match "total cost:") { "YES" } else { "NO" }

        # 2. Extract Data from Output
        $states = if ($output -match "evaluating (\d+) states") { $Matches[1] } else { "0" }
        $searchTime = if ($output -match "([\d.]+)\s+seconds searching") { $Matches[1] } else { "0.00" }
        
        # 3. Handle Cost and Plan Length
        $totalCost = 0
        $planLength = 0
        
        if ($isSolved -eq "YES") {
            # Extract all lines that look like "step X: (ACTION ...)"
            $planSteps = [regex]::Matches($output, "step\s+\d+:\s+\(([\w-]+)")
            $planLength = $planSteps.Count
            
            # Calculate manual cost based on the domain rules 
            foreach ($step in $planSteps) {
                $actionName = $step.Groups[1].Value.ToUpper()
                if ($costTable.ContainsKey($actionName)) {
                    $totalCost += $costTable[$actionName]
                }
            }
            
            # If the planner actually DID provide a cost (like CEHC-Cost does), use its value instead for precision, bu dont use it if cost is 0
            if ($output -match "total cost:\s+([\d.]+)") {
                if ([double]$Matches[1] -ne 0) {
                    $totalCost = $Matches[1]
                }
            }
        } else {
            $totalCost = "N/A"
        }

        "$probNum,$cfgName,$isSolved,$totalCost,$planLength,$states,$searchTime" | Out-File $resultsFile -Append
    }
}