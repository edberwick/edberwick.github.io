import PhotoSwipeLightbox from '/assets/photoswipe/photoswipe-lightbox.esm.js';

const lightbox = new PhotoSwipeLightbox({
  gallery: '.gallery',
  children: 'a',
  pswpModule: () => import('/assets/photoswipe/photoswipe.esm.js'),
  showHideAnimationType: 'zoom',
  preload: [1, 3],
  bgOpacity: 0.85
});

lightbox.init();
