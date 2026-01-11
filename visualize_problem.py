#!/usr/bin/env python3
"""
Dark Souls PDDL Problem Visualizer

Reads a PDDL problem file and generates a visual graph representation
showing locations, connections, player, enemies, items, and shortcuts.
"""

import re
import sys
import argparse
from pathlib import Path
import plotly.graph_objects as go
import networkx as nx


class PDDLProblemParser:
    """Parser for Dark Souls PDDL problem files"""
    
    def __init__(self, filepath):
        self.filepath = Path(filepath)
        self.content = self.filepath.read_text(encoding='utf-8')
        
        # Data structures
        self.locations = set()
        self.bosses = set()
        self.minor_enemies = set()
        self.keys = set()
        
        # State information
        self.connections = []
        self.locked_connections = []
        self.player_location = None
        self.enemy_locations = {}
        self.key_locations = {}
        self.titanite_locations = set()
        self.shortcuts = []
        self.bonfires = set()
        self.blacksmiths = set()
        self.firelink = None
        self.active_bosses = set()
        
    def parse(self):
        """Parse the PDDL problem file"""
        self._parse_objects()
        self._parse_init()
        
    def _parse_objects(self):
        """Extract objects from the :objects section"""
        objects_match = re.search(r'\(:objects\s+(.*?)\s*\)', self.content, re.DOTALL)
        if not objects_match:
            print("WARNING: No :objects section found")
            return
            
        objects_text = objects_match.group(1)
        
        # Parse typed objects line by line (e.g., "firelink passage - location")
        # Match patterns like: name1 name2 ... - type (but not crossing newlines)
        for line in objects_text.split('\n'):
            line = line.strip()
            if not line or line.startswith(';'):
                continue
            
            # Match pattern: names - type
            match = re.match(r'^([\w\-]+(?:\s+[\w\-]+)*)\s+-\s+([\w\-]+)', line)
            if match:
                names = match.group(1).split()
                obj_type = match.group(2)
                
                if obj_type == 'location':
                    self.locations.update(names)
                elif obj_type == 'boss':
                    self.bosses.update(names)
                elif obj_type == 'minor-enemy':
                    self.minor_enemies.update(names)
                elif obj_type == 'key':
                    self.keys.update(names)
    
    def _parse_init(self):
        """Extract initial state from the :init section"""
        init_match = re.search(r'\(:init\s+(.*?)\s*\)\s*\(:goal', self.content, re.DOTALL)
        if not init_match:
            return
            
        init_text = init_match.group(1)
        
        # Parse predicates
        for line in init_text.split('\n'):
            line = line.strip()
            
            # Connected locations
            match = re.search(r'\(connected\s+([\w\-]+)\s+([\w\-]+)\)', line)
            if match:
                from_loc, to_loc = match.groups()
                self.connections.append((from_loc, to_loc))
                continue
            
            # Locked connections
            match = re.search(r'\(locked\s+([\w\-]+)\s+([\w\-]+)\)', line)
            if match:
                from_loc, to_loc = match.groups()
                self.locked_connections.append((from_loc, to_loc))
                continue
            
            # Player location
            match = re.search(r'\(at-player\s+([\w\-]+)\)', line)
            if match:
                self.player_location = match.group(1)
                continue
            
            # Enemy locations
            match = re.search(r'\(enemy-at\s+([\w\-]+)\s+([\w\-]+)\)', line)
            if match:
                enemy, location = match.groups()
                self.enemy_locations[enemy] = location
                continue
            
            # Key locations
            match = re.search(r'\(key-at\s+([\w\-]+)\s+([\w\-]+)\)', line)
            if match:
                key, location = match.groups()
                self.key_locations[key] = location
                continue
            
            # Titanite locations
            match = re.search(r'\(titanite-at\s+([\w\-]+)\)', line)
            if match:
                self.titanite_locations.add(match.group(1))
                continue
            
            # Shortcuts
            match = re.search(r'\(can-open-shortcut\s+([\w\-]+)\s+([\w\-]+)\)', line)
            if match:
                from_loc, to_loc = match.groups()
                self.shortcuts.append((from_loc, to_loc))
                continue
            
            # Bonfires
            match = re.search(r'\(has-bonfire\s+([\w\-]+)\)', line)
            if match:
                self.bonfires.add(match.group(1))
                continue
            
            # Blacksmiths
            match = re.search(r'\(is-blacksmith\s+([\w\-]+)\)', line)
            if match:
                self.blacksmiths.add(match.group(1))
                continue
            
            # Firelink
            match = re.search(r'\(is-firelink\s+([\w\-]+)\)', line)
            if match:
                self.firelink = match.group(1)
                continue
            
            # Active boss locations
            match = re.search(r'\(has-active-boss\s+([\w\-]+)\)', line)
            if match:
                self.active_bosses.add(match.group(1))
                continue


class ProblemVisualizer:
    """Visualizes a parsed PDDL problem as a graph"""
    
    def __init__(self, parser):
        self.parser = parser
        self.graph = nx.DiGraph()
        
    def build_graph(self):
        """Build networkx graph from parsed data"""
        # Add all locations as nodes
        for loc in self.parser.locations:
            self.graph.add_node(loc)
        
        print(f"Added {len(self.graph.nodes())} nodes to graph")
        
        # Add connections as edges
        for from_loc, to_loc in self.parser.connections:
            if from_loc in self.parser.locations and to_loc in self.parser.locations:
                # Check if locked
                is_locked = (from_loc, to_loc) in self.parser.locked_connections
                self.graph.add_edge(from_loc, to_loc, locked=is_locked)
        
        print(f"Added {len(self.graph.edges())} edges to graph")
    
    def plot(self, output_file=None):
        """Generate and display the visualization"""
        if len(self.graph.nodes()) == 0:
            print("ERROR: No nodes in graph! Check problem file parsing.")
            return
        
        # Create a more structured layout
        # Use shell layout centered on firelink for radial structure
        root = self.parser.firelink if self.parser.firelink else list(self.graph.nodes())[0]
        
        try:
            # Try shell layout for organized circular/radial structure
            # Organize nodes by distance from root
            shells = []
            visited = {root}
            current_shell = [root]
            
            while current_shell:
                shells.append(current_shell)
                next_shell = []
                for node in current_shell:
                    neighbors = set(self.graph.successors(node)) | set(self.graph.predecessors(node))
                    for neighbor in neighbors:
                        if neighbor not in visited:
                            visited.add(neighbor)
                            next_shell.append(neighbor)
                current_shell = next_shell
            
            # Add any unconnected nodes to the last shell
            unvisited = set(self.graph.nodes()) - visited
            if unvisited:
                shells.append(list(unvisited))
            
            # Use shell layout with computed shells
            pos = nx.shell_layout(self.graph, nlist=shells, scale=2.5)
            
        except Exception as e:
            print(f"Shell layout failed: {e}, using fallback")
            # Fallback to spectral layout (more organized)
            try:
                pos = nx.spectral_layout(self.graph, scale=2)
            except:
                pos = nx.spring_layout(self.graph, k=3.5, iterations=100, seed=42, scale=2)
        
        # Prepare data for Plotly
        edge_traces = []
        
        # Regular connections
        regular_edges = [(u, v) for u, v, d in self.graph.edges(data=True) if not d.get('locked', False)]
        for edge in regular_edges:
            x0, y0 = pos[edge[0]]
            x1, y1 = pos[edge[1]]
            edge_traces.append(go.Scatter(
                x=[x0, x1, None], y=[y0, y1, None],
                mode='lines',
                line=dict(width=3, color='rgba(180, 180, 180, 0.7)'),
                hoverinfo='none',
                showlegend=False
            ))
        
        # Locked connections
        locked_edges = [(u, v) for u, v, d in self.graph.edges(data=True) if d.get('locked', False)]
        for edge in locked_edges:
            x0, y0 = pos[edge[0]]
            x1, y1 = pos[edge[1]]
            edge_traces.append(go.Scatter(
                x=[x0, x1, None], y=[y0, y1, None],
                mode='lines',
                line=dict(width=3, color='rgba(255, 80, 80, 0.8)', dash='dash'),
                hoverinfo='none',
                name='🚪 Locked',
                showlegend=len(locked_edges) > 0,
                legendgroup='locked'
            ))
        
        # Shortcuts
        for from_loc, to_loc in self.parser.shortcuts:
            if from_loc in pos and to_loc in pos:
                x0, y0 = pos[from_loc]
                x1, y1 = pos[to_loc]
                edge_traces.append(go.Scatter(
                    x=[x0, x1, None], y=[y0, y1, None],
                    mode='lines',
                    line=dict(width=3, color='rgba(100, 255, 100, 0.6)', dash='dot'),
                    hoverinfo='none',
                    name='⚡ Shortcut',
                    showlegend=len(self.parser.shortcuts) > 0,
                    legendgroup='shortcut'
                ))
        
        # Node traces by type
        node_traces = {}
        
        for node in self.graph.nodes():
            x, y = pos[node]
            
            # Determine node type
            node_type = 'regular'
            color = '#90caf9'
            symbol = 'circle'
            size = 50
            
            if node == self.parser.firelink:
                node_type = 'firelink'
                color = '#fbc02d'
                size = 50
            elif node in self.parser.active_bosses:
                node_type = 'boss-room'
                color = '#c62828'
                size = 50
            elif node in self.parser.bonfires:
                node_type = 'bonfire'
                color = '#ff9800'
                size = 50
            elif node in self.parser.blacksmiths:
                node_type = 'blacksmith'
                color = '#757575'
                size = 50
            
            if node_type not in node_traces:
                node_traces[node_type] = {
                    'x': [], 'y': [], 'text': [], 'marker_color': color,
                    'marker_size': size, 'name': node_type
                }
            
            node_traces[node_type]['x'].append(x)
            node_traces[node_type]['y'].append(y)
            node_traces[node_type]['text'].append(node)
        
        # Create node scatter plots with text outline effect
        node_scatter_traces = []
        type_names = {
            'firelink': '🔥 Firelink Shrine',
            'bonfire': '🔥 Bonfire',
            'blacksmith': '🔨 Blacksmith',
            'boss-room': '👹 Boss Room',
            'regular': '📍 Location'
        }
        
        # First pass: add outline (shadow) text layers
        offsets = [(0, 0)]
        

        
        # Second pass: add main text with markers
        for node_type, data in node_traces.items():
            node_scatter_traces.append(go.Scatter(
                x=data['x'], y=data['y'],
                mode='markers+text',
                marker=dict(size=data['marker_size'], color=data['marker_color'],
                           line=dict(width=3, color='#222222')),
                text=data['text'],
                textposition='middle center',
                textfont=dict(size=13, color='black', family='Arial Black'),
                hovertext=data['text'],
                hoverinfo='text',
                name=type_names.get(node_type, node_type),
                showlegend=True
            ))
        for offset_x, offset_y in offsets:
            for node_type, data in node_traces.items():
                outline_x = [x + offset_x for x in data['x']]
                outline_y = [y + offset_y for y in data['y']]
                node_scatter_traces.append(go.Scatter(
                    x=outline_x, y=outline_y,
                    mode='text',
                    text=data['text'],
                    textfont=dict(size=12, color='white', family='Arial Black'),
                    hoverinfo='skip',
                    showlegend=False
                ))

        
        # Entity traces (emojis as scatter points for legend)
        entity_traces = []
        
        # Player
        player_data = {'x': [], 'y': [], 'text': []}
        if self.parser.player_location and self.parser.player_location in pos:
            px, py = pos[self.parser.player_location]
            player_data['x'].append(px)
            player_data['y'].append(py + 0.1)
            player_data['text'].append('🗡️')
        
        if player_data['x']:
            entity_traces.append(go.Scatter(
                x=player_data['x'], y=player_data['y'],
                mode='text',
                text=player_data['text'],
                textfont=dict(size=30),
                hoverinfo='skip',
                name='🗡️ Player',
                showlegend=True
            ))
        
        # Bosses
        boss_data = {'x': [], 'y': [], 'text': []}
        for boss, loc in self.parser.enemy_locations.items():
            if boss in self.parser.bosses and loc in pos:
                bx, by = pos[loc]
                boss_data['x'].append(bx - 0.1)
                boss_data['y'].append(by)
                boss_data['text'].append('👹')
        
        if boss_data['x']:
            entity_traces.append(go.Scatter(
                x=boss_data['x'], y=boss_data['y'],
                mode='text',
                text=boss_data['text'],
                textfont=dict(size=30),
                hoverinfo='skip',
                name='👹 Boss',
                showlegend=True
            ))
        
        # Minor enemies
        enemy_data = {'x': [], 'y': [], 'text': []}
        for enemy, loc in self.parser.enemy_locations.items():
            if enemy in self.parser.minor_enemies and loc in pos:
                ex, ey = pos[loc]
                enemy_data['x'].append(ex + 0.1)
                enemy_data['y'].append(ey)
                enemy_data['text'].append('💀')
        
        if enemy_data['x']:
            entity_traces.append(go.Scatter(
                x=enemy_data['x'], y=enemy_data['y'],
                mode='text',
                text=enemy_data['text'],
                textfont=dict(size=24),
                hoverinfo='skip',
                name='💀 Minor Enemy',
                showlegend=True
            ))
        
        # Keys
        key_data = {'x': [], 'y': [], 'text': []}
        for key, loc in self.parser.key_locations.items():
            if loc in pos:
                kx, ky = pos[loc]
                key_data['x'].append(kx)
                key_data['y'].append(ky - 0.1)
                key_data['text'].append('🔑')
        
        if key_data['x']:
            entity_traces.append(go.Scatter(
                x=key_data['x'], y=key_data['y'],
                mode='text',
                text=key_data['text'],
                textfont=dict(size=24),
                hoverinfo='skip',
                name='🔑 Key',
                showlegend=True
            ))
        
        # Titanite
        titanite_data = {'x': [], 'y': [], 'text': []}
        for loc in self.parser.titanite_locations:
            if loc in pos:
                tx, ty = pos[loc]
                titanite_data['x'].append(tx - 0.1)
                titanite_data['y'].append(ty - 0.1)
                titanite_data['text'].append('💎')
        
        if titanite_data['x']:
            entity_traces.append(go.Scatter(
                x=titanite_data['x'], y=titanite_data['y'],
                mode='text',
                text=titanite_data['text'],
                textfont=dict(size=24),
                hoverinfo='skip',
                name='💎 Titanite',
                showlegend=True
            ))
        
        # Bonfire indicators (show on all bonfire locations)
        bonfire_indicator_data = {'x': [], 'y': [], 'text': []}
        for loc in self.parser.bonfires:
            if loc in pos:
                fx, fy = pos[loc]
                bonfire_indicator_data['x'].append(fx + 0.1)
                bonfire_indicator_data['y'].append(fy + 0.1)
                bonfire_indicator_data['text'].append('🔥')
        
        if bonfire_indicator_data['x']:
            entity_traces.append(go.Scatter(
                x=bonfire_indicator_data['x'], y=bonfire_indicator_data['y'],
                mode='text',
                text=bonfire_indicator_data['text'],
                textfont=dict(size=20),
                hoverinfo='skip',
                showlegend=False  # Already in legend as location type
            ))
        
        # Blacksmith indicators (show on blacksmith locations)
        blacksmith_indicator_data = {'x': [], 'y': [], 'text': []}
        for loc in self.parser.blacksmiths:
            if loc in pos:
                bsx, bsy = pos[loc]
                blacksmith_indicator_data['x'].append(bsx - 0.1)
                blacksmith_indicator_data['y'].append(bsy + 0.1)
                blacksmith_indicator_data['text'].append('🔨')
        
        if blacksmith_indicator_data['x']:
            entity_traces.append(go.Scatter(
                x=blacksmith_indicator_data['x'], y=blacksmith_indicator_data['y'],
                mode='text',
                text=blacksmith_indicator_data['text'],
                textfont=dict(size=20),
                hoverinfo='skip',
                showlegend=False  # Already in legend as location type
            ))
        
        # Create figure
        problem_name = self.parser.filepath.stem
        fig = go.Figure(data=edge_traces + node_scatter_traces + entity_traces,
                       layout=go.Layout(
                           title=dict(
                               text=f'⚔️ Dark Souls Problem Map: {problem_name} ⚔️',
                               font=dict(size=20, color='#e0e0e0')
                           ),
                           showlegend=True,
                           hovermode='closest',
                           margin=dict(b=20, l=5, r=5, t=60),
                           xaxis=dict(showgrid=False, zeroline=False, showticklabels=False),
                           yaxis=dict(showgrid=False, zeroline=False, showticklabels=False),
                           plot_bgcolor='#2b2b2b',
                           paper_bgcolor='#1a1a1a',
                           width=1400,
                           height=900,
                           legend=dict(
                               x=1.02,
                               y=1,
                               bgcolor='rgba(50,50,50,0.95)',
                               bordercolor='#666666',
                               borderwidth=2,
                               font=dict(color='white')
                           )
                       ))
        
        # Save or show
        if output_file:
            if output_file.endswith('.html'):
                fig.write_html(output_file)
            else:
                # For PNG/PDF, use kaleido
                fig.write_image(output_file)
            print(f"Visualization saved to: {output_file}")
        else:
            fig.show()


def main():
    parser = argparse.ArgumentParser(
        description='Visualize Dark Souls PDDL problem files as interactive maps'
    )
    parser.add_argument('--problem_file', type=str, 
                       help='Path to the PDDL problem file')
    parser.add_argument('-o', '--output', type=str, default=None,
                       help='Output file path (HTML/PNG/PDF). If not specified, opens interactive browser view. Use .html for best results.')
    
    args = parser.parse_args()
    
    # Parse problem file
    print(f"Parsing problem file: {args.problem_file}")
    problem_parser = PDDLProblemParser(args.problem_file)
    problem_parser.parse()
    
    print(f"Found {len(problem_parser.locations)} locations")
    print(f"Found {len(problem_parser.bosses)} bosses")
    print(f"Found {len(problem_parser.minor_enemies)} minor enemies")
    print(f"Found {len(problem_parser.keys)} keys")
    
    # Visualize
    print("Generating visualization...")
    visualizer = ProblemVisualizer(problem_parser)
    visualizer.build_graph()
    visualizer.plot(output_file=args.output)


if __name__ == '__main__':
    main()
