sliders = document.querySelectorAll('.slider-score');

if (sliders.length > 0) {
  sliders.forEach(function(slider) {
    var sliderIdSelector = '#' + slider.id
    new Slider(sliderIdSelector);
  });
}
