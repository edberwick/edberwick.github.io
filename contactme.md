---
layout: page
title: Contact
subtitle: Contact
---

My fulltime role is with IBM, so please contact them for wider projects / programmes.

If you'd like to discuss my blog, point out errors or just open up a diaglog, please fill out the form below.

<form action="https://submit-form.com/AFg98qIxe" class="form" id="contact-form">
  <div class="row">
    <div class="col-6">
      <input type="email" name="email" required="required" class="form-control input-lg" placeholder="Email" title="Email" style="margin-bottom: 15px;" />
    </div>
    <div class="col-6">
      <input type="text" name="name" class="form-control input-lg" placeholder="Name" title="Name" style="margin-bottom: 15px;" />
    </div>
  </div>
  <textarea type="text" name="content" class="form-control input-lg" placeholder="Message" title="Message" required="required" rows="3"></textarea>
  <div style="margin-top: 5px; display: flex; margin-bottom: 15px; font-size: 0.7rem;">
    <input type="checkbox" id="formspree-subscribe" name="formspree-subscribe" value="agree" checked="" style="margin-top: 2px; margin-right: 4px;" />
    <label for="formspree-subscribe">Sign up to Shiny newsletter (unsubscribe at any time)</label>
  </div>

  <div class="g-recaptcha" data-sitekey="6Levj9waAAAAAKjnDWEPUfENn91YBRofBG7VxCUP" data-callback="enableSubmitContact"></div>
  <input type="hidden" name="_feedback.success.title" value="Thanks for contacting AttaliTech, we'll be in touch shortly!" />
  <input type="hidden" name="_email.from" value="Formspark AttaliTech" />
  <input type="hidden" name="_feedback.error.title" value="An error occurred (did you check the &quot;I'm not a robot&quot; box?)" />

  <br />
  <button id="submit_contact" type="submit" class="btn btn-lg btn-primary" disabled="">Submit</button>
</form>
