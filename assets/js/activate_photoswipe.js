import PhotoSwipeLightbox from './photoswipe-lightbox.esm.min.js'

const options = {
  gallerySelector: '.photoswipe-gallery',
  childSelector: '.photoswipe',
  pswpModule: '/assets/js/photoswipe.esm.min.js',
  pswpCSS: '/assets/css/photoswipe.min.css'
}

const lightbox = new PhotoSwipeLightbox(options)
lightbox.init()