import pandas as pd
import json
import matplotlib.pyplot as plt
import seaborn as sns
import os

def load_and_preprocess_data(numeric_file, summon_file):
    # Load JSON files
    with open(numeric_file, 'r') as f:
        df_numeric = pd.DataFrame(json.load(f))
        df_numeric['domain'] = 'base'
        
    with open(summon_file, 'r') as f:
        df_summon = pd.DataFrame(json.load(f))
        df_summon['domain'] = 'summon'
        
    # Combine datasets
    df = pd.concat([df_numeric, df_summon], ignore_index=True)
    
    # Map engine names to readable labels
    engine_map = {
        'enhsp': 'Satisficing',
        'OPT-enhsp': 'Optimal',
        'Anytime-enhsp': 'Anytime'
    }
    df['engine_label'] = df['engine'].map(engine_map)
    
    # Filter for solved problems only
    solved_statuses = [
        'PlanGenerationResultStatus.SOLVED_SATISFICING', 
        'PlanGenerationResultStatus.SOLVED_OPTIMALLY'
    ]
    # also include timeout for anytime planners
    solved_statuses.append('PlanGenerationResultStatus.TIMEOUT')
    df_solved = df[df['status'].isin(solved_statuses)].copy()
    # now for all TIMEOUT entries, we need to ensure they have a plan, keep only those
    df_solved = df_solved[~((df_solved['status'] == 'PlanGenerationResultStatus.TIMEOUT') & (df_solved['plan_length'] == 0))]
    #replace problem names with shorter versions (just the number)
    df_solved['problem'] = df_solved['problem'].str.extract('(\d+)').astype(int)
    
    return df, df_solved

def generate_plots(df, df_solved):
    sns.set_theme(style="whitegrid")
    os.makedirs('plots', exist_ok=True)
    # 1. Coverage Plot
    plt.figure(figsize=(10, 6))
    coverage = df_solved.groupby(['engine_label', 'domain'])['problem'].nunique().reset_index()
    sns.barplot(data=coverage, x='engine_label', y='problem', hue='domain', palette='viridis')
    plt.title('Coverage: Number of Problems Solved')
    plt.ylabel('Problems Solved')
    plt.xlabel('Planner Engine')
    plt.savefig('plots/coverage.png', bbox_inches='tight')
    plt.close()

    # 2. Cactus Plot (Runtime)
    plt.figure(figsize=(10, 6))
    for (engine, domain), group in df_solved.sort_values('total_time_ms').groupby(['engine_label', 'domain']):
        times = group['total_time_ms'].values / 1000.0  # Convert to seconds
        n_solved = range(1, len(times) + 1)
        plt.plot(times, n_solved, label=f"{engine} ({domain})", marker='o', markersize=4)
    plt.title('Cactus Plot: Number of Problems Solved vs. Time')
    plt.xlabel('Time (seconds)')
    plt.ylabel('Problems Solved')
    plt.legend()
    plt.savefig('plots/cactus_runtime.png', bbox_inches='tight')
    plt.close()

    # 3. Plan Quality Scatter Plot (Cost) with problem id labels
    df_pivot_metric = df_solved.pivot_table(index=['problem', 'engine_label'], columns='domain', values='metric').dropna().reset_index()
    plt.figure(figsize=(8, 8))
    sns.scatterplot(data=df_pivot_metric, x='base', y='summon', hue='engine_label', s=100)
    # Add problem id labels
    for _, row in df_pivot_metric.iterrows():
        plt.text(row['base'], row['summon'], str(row['problem']), fontsize=20, alpha=0.9)
    max_val = max(df_pivot_metric['base'].max(), df_pivot_metric['summon'].max())
    plt.plot([0, max_val], [0, max_val], 'r--', alpha=0.5, label='Equal Cost')
    plt.title('Plan Quality: Base vs. Summon (Metric Value)')
    plt.xlabel('Metric (Base Domain)')
    plt.ylabel('Metric (Summon Domain)')
    plt.legend()
    plt.savefig('plots/quality_comparison.png', bbox_inches='tight')
    plt.close()

    # 4. Search Effort (Nodes Expanded) with problem id labels
    df_pivot_nodes = df_solved.pivot_table(index=['problem', 'engine_label'], columns='domain', values='expanded_nodes').dropna().reset_index()
    plt.figure(figsize=(8, 8))
    sns.scatterplot(data=df_pivot_nodes, x='base', y='summon', hue='engine_label', s=100)
    # Add problem id labels
    for _, row in df_pivot_nodes.iterrows():
        plt.text(row['base'], row['summon'], str(row['problem']), fontsize=20, alpha=0.9)
    max_val_nodes = max(df_pivot_nodes['base'].max(), df_pivot_nodes['summon'].max())
    plt.plot([1, max_val_nodes], [1, max_val_nodes], 'r--', alpha=0.5, label='Equal Nodes')
    plt.xscale('log')
    plt.yscale('log')
    plt.title('Search Effort: Nodes Expanded (Log Scale)')
    plt.xlabel('Nodes (Base Domain)')
    plt.ylabel('Nodes (Summon Domain)')
    plt.legend()
    plt.savefig('plots/search_effort.png', bbox_inches='tight')
    plt.close()

    # 5. Cost Comparison per Problem (Grouped Bar Chart)
    g = sns.catplot(
        data=df_solved, 
        x='problem', 
        y='metric', 
        hue='domain', 
        col='engine_label', 
        kind='bar',
        palette='muted',
        height=5, 
        aspect=1.2,
        sharey=True
    )
    g.set_axis_labels("Problem ID", "Plan Metric (Cost)")
    g.fig.suptitle('Cost Comparison per Problem across Domains', y=1.05)
    plt.savefig('plots/cost_per_problem.png', bbox_inches='tight')
    plt.close()

if __name__ == "__main__":
    num_file = 'benchmark_results_numeric.json'
    sum_file = 'benchmark_results_summon.json'
    
    full_df, solved_df = load_and_preprocess_data(num_file, sum_file)
    generate_plots(full_df, solved_df)
    
    print("All plots generated successfully.")