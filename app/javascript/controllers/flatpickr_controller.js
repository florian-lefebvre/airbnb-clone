import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startDate", "endDate" ]
  connect() {

    flatpickr(this.startDateTarget, {

      defaultDate: "today",
      altInput: true,
      enableDate: true,
      altFormat: "F j, Y",
      minDate: "today",
      dateFormat: "Y-m-d",
      enable: [
        {
          from: "today",
          to: new Date().fp_incr(60) // 60 days from now
        }
      ]


    });
    flatpickr(this.endDateTarget, {
      altInput: true,
      enableDate: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      enable: [
        {
          from: "today",
          to: new Date().fp_incr(60) // 60 days from now
        }
      ]

    });

  }
}
