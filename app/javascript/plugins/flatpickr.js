import flatpickr from "flatpickr";

const initFlatpickr = () => {
  const simone = document.querySelector('.datepicker')
  if (simone) {
    flatpickr(".datepicker", {
      allowInput: true,
      enableTime: true
    });
  }
}

export { initFlatpickr };
