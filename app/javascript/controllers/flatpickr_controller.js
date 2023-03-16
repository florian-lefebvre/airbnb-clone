import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startDate", "endDate" ]
  connect() {
    flatpickr(this.startDateTarget, {
      // minDate: "today",
      // defaultDate: "today",
      // enableDate: true,
      // altInput: true,
      // altFormat: "F j, Y",
      // dateFormat: "Y-m-d",
      // enable: [
      //   {
      //     from: "today",
      //     to: new Date().fp_incr(60) // 7 days from now
      //   }
      // ]
      mode: "range",
      minDate: "today",
      dateFormat: "Y-m-d",
      disable: [
          function(date) {
              // disable every multiple of 8
              return !(date.getDate() % 8);
          }
      ]

    });
    flatpickr(this.endDateTarget, {
      defaultDate: new Date().fp_incr(5),
      altInput: true,
      enableDate: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      enable: [
        {
          from: "today",
          to: new Date().fp_incr(60) // 7 days from now
        }
      ]

    });
  }
}
