# Build the site via nix
build:
    nix build

# Validate graph data integrity
validate:
    node -e "const d=require('./data/graph.json'); const ids=new Set(d.nodes.map(n=>n.id)); let ok=true; d.edges.forEach((e,i)=>{if(!ids.has(e.source)){console.error('BAD source e'+i+': '+e.source);ok=false}if(!ids.has(e.target)){console.error('BAD target e'+i+': '+e.target);ok=false}}); if(!ok)process.exit(1); console.log(d.nodes.length+' nodes, '+d.edges.length+' edges — OK')"

ci: build validate

# Serve locally
serve: build
    npx serve result -p 10001
