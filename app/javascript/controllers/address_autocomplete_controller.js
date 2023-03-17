import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String, defaultAddress: String };

  static targets = ["address"];

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
    });
    this.geocoder.addTo(this.element);
    this.geocoder.on("result", (event) => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());
    this.element.children[this.element.children.length - 1].children[1].value =
      this.defaultAddressValue;
  }

  disconnect() {
    this.geocoder.onRemove();
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"];
  }

  #clearInputValue() {
    this.addressTarget.value = "";
  }
}
