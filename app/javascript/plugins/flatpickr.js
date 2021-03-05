import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    allowInput: true,
    enableTime: true
  });
}

export { initFlatpickr };
