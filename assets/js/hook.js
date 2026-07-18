import L from "leaflet";

let Hooks = {};

Hooks.HiveMap = {
  mounted() {
    // 1. Initialiser la carte centrée sur la France par exemple
    this.map = L.map(this.el).setView([46.603354, 1.888334], 6);

    // 2. Charger les tuiles gratuites d'OpenStreetMap
    L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
    attribution: '© OpenStreetMap contributors © CARTO',
    subdomains: 'abcd',
    maxZoom: 19
    }).addTo(this.map);

    // 3. Écouter les événements envoyés par Elixir/LiveView
    this.handleEvent("load-markers", ({ spots }) => {
      spots.forEach(spot => {
        L.marker([spot.lat, spot.lng])
         .addTo(this.map)
         .bindPopup(`<b>${spot.name}</b><br>${spot.description}`);
      });
    });

    // 4. Clic sur la carte pour ajouter un point (Optionnel)
    this.map.on("click", (e) => {
      // Envoyer les coordonnées au serveur LiveView Elixir
      this.pushEvent("map-clicked", { lat: e.latlng.lat, lng: e.latlng.lng });
    });
  }
};
export default Hooks;