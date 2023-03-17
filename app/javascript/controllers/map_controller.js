import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    new MutationObserver(([{ oldValue }]) => {
      let newValue = document.documentElement.getAttribute(
        "data-bs-theme"
      );
      if (newValue !== oldValue) {
        this.map.setStyle(`mapbox://styles/mapbox/${newValue}-v11`);
      }
    }).observe(document.documentElement, {
      attributeFilter: ["data-bs-theme"],
      attributeOldValue: true,
    });

    const theme = document.documentElement.getAttribute("data-bs-theme");

    this.map = new mapboxgl.Map({
      container: this.element,
      style: `mapbox://styles/mapbox/${theme}-v11`,
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();

    this.map.addControl(
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
      })
    );
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = marker.info_window_html
        ? new mapboxgl.Popup().setHTML(marker.info_window_html)
        : undefined;

      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
