import PhotoSwipeLightbox from '/assets/photoswipe/photoswipe-lightbox.esm.min.js';

const lightbox = new PhotoSwipeLightbox({
  gallery: '.gallery',
  children: 'a',
  pswpModule: () => import('/assets/photoswipe/photoswipe.esm.min.js'),
});

lightbox.init();