import PhotoSwipeLightbox from '/assets/photoswipe/photoswipe-lightbox.esm.js';

const lightbox = new PhotoSwipeLightbox({
  gallery: '.gallery',
  children: 'a',
  pswpModule: () => import('/assets/photoswipe/photoswipe.esm.js'),
});

lightbox.init();