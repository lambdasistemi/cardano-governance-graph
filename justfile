# Build the site via nix
build:
    nix build

# Validate the configured RDF sources parse correctly
validate:
    node -e "const fs=require('fs'); const ox=require('oxigraph'); const cfg=JSON.parse(fs.readFileSync('data/config.json','utf8')); const sources=cfg.graphSources ?? [cfg.graphSource]; for (const src of sources) { const s=new ox.Store(); s.load(fs.readFileSync(src.path,'utf8'),{format:src.format,base_iri:'https://graph-browser.invalid/'}); console.log(src.path+': '+s.size+' triples — OK'); }"

ci: build validate

# Serve locally
serve: build
    npx serve result -p 10001
