import { Component, inject } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Component({
  imports: [],
  selector: 'app-about-us',
  styleUrl: './about-us.scss',
  templateUrl: './about-us.html',
})
export class AboutUs {
  private sanitizer = inject(DomSanitizer);
  srcMap!: SafeResourceUrl;

  ngOnInit() {
    const rawUrl = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.9576907262212!2d106.82926929999999!3d-6.136387099999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69f5185c48556f%3A0xce93f74ecbe0c998!2sBogamas%20Maju%20Indonesia!5e0!3m2!1sen!2sid!4v1788093413525!5m2!1sen!2sid';
    this.srcMap = this.sanitizer.bypassSecurityTrustResourceUrl(rawUrl);
  }

}
