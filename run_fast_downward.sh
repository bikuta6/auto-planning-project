#!/bin/bash

# Fast Downward Experiment Automation Script
# Author: Victor Ramos Osuna
# Course: Automatic Planning - UC3M
# Description: Automates running Fast Downward planners on benchmark problems

# Configuration
FAST_DOWNWARD_PATH=../downward/fast-downward.py
BENCHMARKS_DIR=./
TIME_LIMIT=1800
OUTPUT_DIR=./experiment_results_fd
LOG_DIR=${OUTPUT_DIR}/logs
SUMMARY_DIR=${OUTPUT_DIR}/summaries

# Planners configuration (using arrays for bash compatibility)
PLANNER_NAMES=("lama-first" "lama" "fdss-opt")
PLANNER_ALIASES=("lama-first" "seq-sat-lama-2011" "seq-opt-fdss-1")

# Domains to test (optimal track domains)
DOMAINS=(
    "darksouls-fd"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_colored() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to create directories
setup_directories() {
    print_colored $BLUE "Setting up experiment directories..."
    mkdir -p $OUTPUT_DIR
    mkdir -p $LOG_DIR
    mkdir -p $SUMMARY_DIR

    for domain in "${DOMAINS[@]}"; do
        mkdir -p ${LOG_DIR}/${domain}
        for planner in "${PLANNER_NAMES[@]}"; do
            mkdir -p ${LOG_DIR}/${domain}/${planner}
        done
    done

    print_colored $GREEN "Directories created successfully!"
}

# Function to check if Fast Downward exists
check_fast_downward() {
    if [ ! -f "$FAST_DOWNWARD_PATH" ]; then
        print_colored $RED "Error: Fast Downward not found at $FAST_DOWNWARD_PATH"
        exit 1
    fi
    print_colored $GREEN "Fast Downward found at $FAST_DOWNWARD_PATH"
}



# Function to check if benchmarks directory exists
check_benchmarks() {
    if [ ! -d "$BENCHMARKS_DIR" ]; then
        print_colored $RED "Error: Benchmarks directory not found at $BENCHMARKS_DIR"
        exit 1
    fi
    print_colored $GREEN "Benchmarks directory found at $BENCHMARKS_DIR"
}

# Function to get problem files from a domain (first 10)
get_problems() {
    local domain=$1
    local domain_path="${BENCHMARKS_DIR}/${domain}"

    if [ ! -d "$domain_path" ]; then
        print_colored $RED "Error: Domain directory not found: $domain_path"
        return 1
    fi

    # Get all .pddl files except domain.pddl, sort them
    find "$domain_path" -name "*.pddl" -not -name "domain.pddl" | sort
}

# Function to get exit code explanation
get_exit_code_explanation() {
    local exit_code=$1
    case $exit_code in
        0) echo "SUCCESS (solution found)" ;;
        1) echo "CRITICAL ERROR (translation/input error)" ;;
        2) echo "PARTIAL SUCCESS (portfolio mixed results, solution found)" ;;
        23) echo "TIMEOUT (time limit exceeded)" ;;
        30) echo "OUT OF MEMORY (memory limit exceeded)" ;;
        32) echo "SEARCH FAILED (no solution exists or search space exhausted)" ;;
        *) echo "UNKNOWN ERROR (exit code $exit_code)" ;;
    esac
}

# Function to get status from exit code
get_status_from_exit_code() {
    local exit_code=$1
    case $exit_code in
        0|2) echo "SUCCESS" ;;  # Both 0 and 2 indicate solutions were found
        1) echo "CRITICAL_ERROR" ;;
        23) echo "TIMEOUT" ;;
        30) echo "OUT_OF_MEMORY" ;;
        32) echo "NO_SOLUTION" ;;
        *) echo "FAILED" ;;
    esac
}

# Function to check if exit code represents a solved problem
is_solved() {
    local exit_code=$1
    case $exit_code in
        0|2) return 0 ;;  # Success cases
        *) return 1 ;;    # All other cases are unsolved
    esac
}

# Function to run a single experiment
run_experiment() {
    local domain=$1
    local planner_name=$2
    local planner_alias=$3
    local problem_file=$4

    local domain_file="${BENCHMARKS_DIR}/${domain}/domain.pddl"
    local log_file="${LOG_DIR}/${domain}/${planner_name}/$(basename $problem_file .pddl).log"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    # Check if experiment already completed
    if [ -f "$log_file" ] && grep -q "=== Experiment Summary ===" "$log_file" && grep -q "Exit Code:" "$log_file"; then
        local existing_exit_code=$(grep "Exit Code:" "$log_file" | tail -1 | sed 's/.*Exit Code: \([0-9]*\).*/\1/' 2>/dev/null)
        local existing_status=$(get_status_from_exit_code $existing_exit_code)
        print_colored $BLUE "[$timestamp] Skipping $planner_name on $domain/$(basename $problem_file) - already completed"

        # Show existing result
        if is_solved $existing_exit_code; then
            print_colored $GREEN "  ✓ Previously solved (exit code $existing_exit_code)"
        elif [ $existing_exit_code -eq 23 ]; then
            print_colored $YELLOW "  ⏱ Previously timed out (exit code $existing_exit_code)"
        elif [ $existing_exit_code -eq 30 ]; then
            print_colored $YELLOW "  💾 Previously ran out of memory (exit code $existing_exit_code)"
        elif [ $existing_exit_code -eq 32 ]; then
            print_colored $RED "  ❌ Previously found no solution (exit code $existing_exit_code)"
        else
            print_colored $RED "  ✗ Previously failed: $(get_exit_code_explanation $existing_exit_code)"
        fi
        return 0
    fi

    print_colored $YELLOW "[$timestamp] Running $planner_name on $domain/$(basename $problem_file)"

    # Create log header
    cat > "$log_file" << EOF
=== Fast Downward Experiment Log ===
Domain: $domain
Planner: $planner_name ($planner_alias)
Problem: $(basename $problem_file)
Time Limit: $TIME_LIMIT seconds
Start Time: $timestamp
Domain File: $domain_file
Problem File: $problem_file

=== Fast Downward Output ===
EOF

    # Run Fast Downward with built-in timeout
    local start_time=$(date +%s)

    python3 "$FAST_DOWNWARD_PATH" \
        --alias "$planner_alias" \
        --search-time-limit "${TIME_LIMIT}s" \
        "$domain_file" \
        "$problem_file" >> "$log_file" 2>&1

    local exit_code=$?
    local end_time=$(date +%s)
    local runtime=$((end_time - start_time))

    local status=$(get_status_from_exit_code $exit_code)
    local explanation=$(get_exit_code_explanation $exit_code)

    # Add footer to log
    cat >> "$log_file" << EOF

=== Experiment Summary ===
End Time: $(date '+%Y-%m-%d %H:%M:%S')
Runtime: $runtime seconds
Exit Code: $exit_code
Status: $status
Explanation: $explanation
EOF

    # Print result with detailed explanation
    if is_solved $exit_code; then
        print_colored $GREEN "  ✓ Solved in ${runtime}s (exit code $exit_code)"
    elif [ $exit_code -eq 23 ]; then
        print_colored $YELLOW "  ⏱ Timeout after ${TIME_LIMIT}s (exit code $exit_code)"
    elif [ $exit_code -eq 30 ]; then
        print_colored $YELLOW "  💾 Out of memory (exit code $exit_code)"
    elif [ $exit_code -eq 32 ]; then
        print_colored $RED "  ❌ No solution found (exit code $exit_code)"
    else
        print_colored $RED "  ✗ Failed: $(get_exit_code_explanation $exit_code)"
    fi
}

# Function to extract metrics from log file
extract_metrics() {
    local log_file=$1
    local domain=$2
    local planner=$3
    local problem=$(basename "$log_file" .log)

    # Default values
    local solved="NO"
    local runtime="N/A"
    local plan_length="N/A"
    local plan_cost="N/A"
    local expanded_nodes="N/A"
    local generated_nodes="N/A"
    local search_time="N/A"
    local total_time="N/A"
    local exit_code="N/A"

    if [ -f "$log_file" ]; then
        # Extract exit code from log
        exit_code=$(grep "Exit Code:" "$log_file" | tail -1 | sed 's/.*Exit Code: \([0-9]*\).*/\1/' 2>/dev/null)

        # Determine if solved based on exit code and solution found
        if [ -n "$exit_code" ] && ([ "$exit_code" = "0" ] || [ "$exit_code" = "2" ]); then
            solved="YES"
        elif grep -q "Solution found!" "$log_file" || grep -q "Solution found" "$log_file"; then
            solved="YES"
        fi

        # Handle specific exit codes
        if [ "$exit_code" = "23" ]; then
            solved="TIMEOUT"
        elif [ "$exit_code" = "30" ]; then
            solved="OUT_OF_MEMORY"
        elif [ "$exit_code" = "32" ]; then
            solved="NO_SOLUTION"
        elif [ "$exit_code" = "1" ]; then
            solved="CRITICAL_ERROR"
        elif grep -q "time limit has been reached" "$log_file" || grep -q "overall time limit" "$log_file"; then
            solved="TIMEOUT"
        elif grep -q "FAILED" "$log_file"; then
            solved="FAILED"
        fi

        # Extract metrics from Fast Downward output format
        if [ "$solved" = "YES" ]; then
            # Plan length: "Plan length: 8 step(s)."
            plan_length=$(grep "Plan length:" "$log_file" | tail -1 | sed 's/.*Plan length: \([0-9]*\) step.*/\1/' 2>/dev/null)
            # Plan cost: "Plan cost: 8"
            plan_cost=$(grep "Plan cost:" "$log_file" | tail -1 | sed 's/.*Plan cost: \([0-9.]*\).*/\1/' 2>/dev/null)
        fi

        # Extract search statistics
        # Handle both formats: "Expanded 9 state(s)." and "[t=0.001829s, KB] Expanded 9 state(s)."
        expanded_nodes=$(grep "Expanded.*state" "$log_file" | grep -v "until last jump" | tail -1 | sed 's/.*Expanded \([0-9]*\) state.*/\1/' 2>/dev/null)

        # Handle both formats: "Generated 22 state(s)." and "[t=0.001829s, KB] Generated 22 state(s)."
        generated_nodes=$(grep "Generated.*state" "$log_file" | grep -v "until last jump" | tail -1 | sed 's/.*Generated \([0-9]*\) state.*/\1/' 2>/dev/null)

        # Extract timing information
        # Search time: "Search time: 0.000103s"
        search_time=$(grep "Search time:" "$log_file" | tail -1 | sed 's/.*Search time: \([0-9.]*\)s.*/\1/' 2>/dev/null)
        # Total time: "Total time: 0.002465s"
        total_time=$(grep "Total time:" "$log_file" | tail -1 | sed 's/.*Total time: \([0-9.]*\)s.*/\1/' 2>/dev/null)

        # If Fast Downward times are not available, use our runtime measurement
        runtime=$(grep "Runtime:" "$log_file" | sed 's/.*Runtime: \([0-9]*\) seconds.*/\1/' 2>/dev/null)

        # Prefer Fast Downward's total time if available, otherwise use our measurement
        if [ "$total_time" != "N/A" ] && [ -n "$total_time" ] && [ "$total_time" != "" ]; then
            runtime="$total_time"
        elif [ -z "$runtime" ] || [ "$runtime" = "" ]; then
            runtime="N/A"
        fi

        # Clean up any empty values
        [ -z "$plan_length" ] && plan_length="N/A"
        [ -z "$plan_cost" ] && plan_cost="N/A"
        [ -z "$expanded_nodes" ] && expanded_nodes="N/A"
        [ -z "$generated_nodes" ] && generated_nodes="N/A"
        [ -z "$exit_code" ] && exit_code="N/A"
    fi

    echo "$domain,$planner,$problem,$solved,$runtime,$plan_length,$plan_cost,$expanded_nodes,$generated_nodes,$exit_code"
}

# Function to generate summary report
generate_summary() {
    print_colored $BLUE "Generating summary reports..."

    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local summary_file="${SUMMARY_DIR}/experiment_summary_${timestamp}.csv"
    local detailed_report="${SUMMARY_DIR}/detailed_report_${timestamp}.txt"

    # Create CSV header
    echo "Domain,Planner,Problem,Solved,Total_Time(s),Plan_Length,Plan_Cost,Expanded_Nodes,Generated_Nodes,Exit_Code" > "$summary_file"

    # Process all log files
    for domain in "${DOMAINS[@]}"; do
        for planner in "${PLANNER_NAMES[@]}"; do
            local log_dir="${LOG_DIR}/${domain}/${planner}"
            if [ -d "$log_dir" ]; then
                for log_file in "$log_dir"/*.log; do
                    if [ -f "$log_file" ]; then
                        extract_metrics "$log_file" "$domain" "$planner" >> "$summary_file"
                    fi
                done
            fi
        done
    done

    # Generate detailed text report
    cat > "$detailed_report" << EOF
=== FAST DOWNWARD EXPERIMENT REPORT ===
Generated on: $(date '+%Y-%m-%d %H:%M:%S')
Time Limit: $TIME_LIMIT seconds
Domains Tested: ${DOMAINS[*]}
Planners Tested: ${PLANNER_NAMES[*]}

=== PLANNER CONFIGURATIONS ===
- lama-first: LAMA planner with unit costs, returns first solution found
  Command: --alias lama-first
- lama: Full LAMA planner from IPC'11 satisficing track
  Command: --alias seq-sat-lama-2011
- fdss-opt: FDSS optimal planner from IPC'11 optimal track
  Command: --alias seq-opt-fdss-1

=== COVERAGE ANALYSIS ===
EOF

    # Calculate coverage statistics
    for domain in "${DOMAINS[@]}"; do
        echo "" >> "$detailed_report"
        echo "Domain: $domain" >> "$detailed_report"
        echo "----------------------------------------" >> "$detailed_report"

        for planner in "${PLANNER_NAMES[@]}"; do
            local total=0
            local solved=0

            # Count problems and solved problems
            if [ -d "${LOG_DIR}/${domain}/${planner}" ]; then
                for log_file in "${LOG_DIR}/${domain}/${planner}"/*.log; do
                    if [ -f "$log_file" ]; then
                        total=$((total + 1))
                        # Check exit code for solved status
                        local exit_code=$(grep "Exit Code:" "$log_file" | tail -1 | sed 's/.*Exit Code: \([0-9]*\).*/\1/' 2>/dev/null)
                        if [ "$exit_code" = "0" ] || [ "$exit_code" = "2" ] || grep -q "Solution found!" "$log_file"; then
                            solved=$((solved + 1))
                        fi
                    fi
                done
            fi

            local coverage_pct=0
            if [ $total -gt 0 ]; then
                coverage_pct=$((solved * 100 / total))
            fi

            printf "%-15s: %2d/%2d solved (%3d%%)\n" "$planner" "$solved" "$total" "$coverage_pct" >> "$detailed_report"
        done
    done

    cat >> "$detailed_report" << EOF

=== FILES GENERATED ===
- Detailed logs: $LOG_DIR/
- Summary CSV: $summary_file
- This report: $detailed_report

=== ANALYSIS TIPS FOR YOUR REPORT ===
1. Coverage Comparison: Compare solved/total ratios across planners
2. Runtime Analysis: Analyze timing differences between planners
3. Plan Quality: Compare plan length and cost metrics
4. Search Efficiency: Compare expanded/generated nodes ratios
5. Domain-Specific Performance: Analyze performance per domain

=== METRICS EXPLANATION ===
- Solved: YES/NO/TIMEOUT/OUT_OF_MEMORY/NO_SOLUTION/CRITICAL_ERROR/FAILED
- Total_Time(s): Complete execution time including translation
- Plan_Length: Number of actions in the solution
- Plan_Cost: Total cost of the plan
- Expanded_Nodes: States expanded during search
- Generated_Nodes: States generated during search
- Exit_Code: Fast Downward's exit code

=== EXIT CODE MEANINGS ===
- 0: SUCCESS (clean solution found)
- 2: PARTIAL SUCCESS (portfolio found solution despite some component failures)
- 23: TIMEOUT (time limit exceeded)
- 30: OUT OF MEMORY (memory limit exceeded)
- 32: NO SOLUTION (search completed but no solution exists)
- 1: CRITICAL ERROR (translation failed, invalid input, etc.)

=== EXPECTED RESULTS ===
- LAMA-first: Fast, may find suboptimal solutions, exit codes 0/2
- LAMA: Balanced speed/quality, satisficing solutions, exit codes 0/2
- FDSS-opt: Slower optimal planner, more likely timeouts (exit code 23)

EOF

    print_colored $GREEN "Summary reports generated:"
    print_colored $GREEN "  CSV: $summary_file"
    print_colored $GREEN "  Report: $detailed_report"
}

# Function to show experiment progress
show_progress() {
    local current=$1
    local total=$2
    local percentage=$((current * 100 / total))
    print_colored $BLUE "Progress: $current/$total experiments completed ($percentage%)"
}

# Main execution function
main() {
    print_colored $BLUE "=== Fast Downward Experiment Suite ==="
    print_colored $BLUE "Starting automated experiments at $(date)"

    # Initial checks
    check_fast_downward
    check_benchmarks
    setup_directories

    # Count total experiments
    local total_experiments=0
    for domain in "${DOMAINS[@]}"; do
        local problems=$(get_problems "$domain")
        local problem_count=$(echo "$problems" | wc -l)
        total_experiments=$((total_experiments + problem_count * ${#PLANNER_NAMES[@]}))
    done

    print_colored $YELLOW "Total experiments to run: $total_experiments"
    print_colored $YELLOW "Estimated time: $((total_experiments * TIME_LIMIT / 60)) minutes (worst case)"

    # Ask for confirmation
    echo -n "Do you want to continue? (y/N): "
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_colored $YELLOW "Experiment cancelled by user."
        exit 0
    fi

    # Check for existing experiments
    local existing_experiments=0
    local total_existing=0
    for domain in "${DOMAINS[@]}"; do
        local problems=$(get_problems "$domain")
        if [ -n "$problems" ]; then
            while IFS= read -r problem_file; do
                for i in "${!PLANNER_NAMES[@]}"; do
                    local log_file="${LOG_DIR}/${domain}/${PLANNER_NAMES[$i]}/$(basename $problem_file .pddl).log"
                    total_existing=$((total_existing + 1))
                    if [ -f "$log_file" ] && grep -q "=== Experiment Summary ===" "$log_file" && grep -q "Exit Code:" "$log_file"; then
                        existing_experiments=$((existing_experiments + 1))
                    fi
                done
            done <<< "$problems"
        fi
    done

    if [ $existing_experiments -gt 0 ]; then
        print_colored $YELLOW "Found $existing_experiments existing completed experiments out of $total_experiments total"
        print_colored $YELLOW "Will skip completed experiments and run remaining $((total_experiments - existing_experiments))"
        echo -n "Continue with remaining experiments? (y/N): "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            print_colored $YELLOW "Experiment cancelled by user."
            exit 0
        fi
    fi

    # Run experiments
    local current_experiment=0
    local skipped_experiments=0
    local new_experiments=0

    for domain in "${DOMAINS[@]}"; do
        print_colored $BLUE "\n=== Testing domain: $domain ==="

        local problems=$(get_problems "$domain")
        if [ -z "$problems" ]; then
            print_colored $RED "No problems found for domain $domain"
            continue
        fi

        local problem_count=$(echo "$problems" | wc -l)
        print_colored $YELLOW "Found $problem_count problems in $domain"

        while IFS= read -r problem_file; do
            for i in "${!PLANNER_NAMES[@]}"; do
                current_experiment=$((current_experiment + 1))
                show_progress $current_experiment $total_experiments

                # Check if experiment already exists
                local log_file="${LOG_DIR}/${domain}/${PLANNER_NAMES[$i]}/$(basename $problem_file .pddl).log"
                if [ -f "$log_file" ] && grep -q "=== Experiment Summary ===" "$log_file" && grep -q "Exit Code:" "$log_file"; then
                    skipped_experiments=$((skipped_experiments + 1))
                    # Still call function to show skip message
                    run_experiment "$domain" "${PLANNER_NAMES[$i]}" "${PLANNER_ALIASES[$i]}" "$problem_file"
                else
                    new_experiments=$((new_experiments + 1))
                    run_experiment "$domain" "${PLANNER_NAMES[$i]}" "${PLANNER_ALIASES[$i]}" "$problem_file"
                fi
            done
        done <<< "$problems"
    done

    print_colored $GREEN "\n=== All experiments completed! ==="
    print_colored $BLUE "Experiment Summary:"
    print_colored $GREEN "  ✓ New experiments run: $new_experiments"
    print_colored $YELLOW "  ⏭ Skipped (already done): $skipped_experiments"
    print_colored $BLUE "  📊 Total processed: $current_experiment experiments"

    generate_summary

    print_colored $BLUE "\n=== Experiment Complete ==="
    print_colored $GREEN "Results are available in: $OUTPUT_DIR"
    print_colored $YELLOW "Don't forget to analyze the results for your report!"
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
