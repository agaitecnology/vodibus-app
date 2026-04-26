import json
import unicodedata

def corrigir_encoding(texto):
    try:
        return texto.encode('latin1').decode('utf-8')
    except (UnicodeDecodeError, UnicodeEncodeError):
        return texto

def parse_osm(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        conteudo = f.read()
    
    # Corrige encoding antes de parsear
    conteudo = conteudo.encode('utf-8').decode('unicode_escape').encode('latin1').decode('utf-8')
    
    data = json.loads(conteudo)
    stops = []
    elements = data.get("elements", [])

    for el in elements:
        if el.get("type") == "node":
            tags = el.get("tags", {})
            if tags.get("highway") == "bus_stop":
                nome = corrigir_encoding(tags.get("name", "").strip())
                stop = {
                    "id": el.get("id"),
                    "lat": el.get("lat"),
                    "lon": el.get("lon"),
                    "name": nome
                }
                stops.append(stop)

    return stops

if __name__ == "__main__":
    file_path = "bus_stops_osm.json"
    stops = parse_osm(file_path)
    print(f"Total de pontos encontrados: {len(stops)}")
    for s in stops[:10]:
        print(s)
    with open("bus_stops_parsed.json", "w", encoding="utf-8") as f:
        json.dump(stops, f, ensure_ascii=False, indent=2)
    print("Arquivo bus_stops_parsed.json gerado!")