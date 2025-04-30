# generate-gallery.rb
require 'erb'

gallery = ARGV[0]
images = Dir.glob("uploads/#{gallery}/watermarked/*.{jpg,jpeg,png}")

template = ERB.new <<-HTML
<div class="gallery">
<% images.each do |img| %>
  <% name = File.basename(img) %>
  <a href="/uploads/#{gallery}/watermarked/<%= name %>"
     data-pswp-width="1600"
     data-pswp-height="1067"
     target="_blank">
    <img src="/uploads/#{gallery}/thumbs/<%= name %>" loading="lazy" />
  </a>
<% end %>
</div>
HTML

puts template.result