import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  standalone: true,
  imports: [RouterLink, RouterLinkActive],
  selector: 'app-header',
  styleUrl: './header.scss',
  templateUrl: './header.html',
})
export class Header {
  navMenus = [
    { text: 'Home', path: '/', exact: true },
    { text: 'Products', path: '/products', exact: false },
    { text: 'About Us', path: '/about-us', exact: false },
    { text: 'Our Service', path: '/our-service', exact: false },
    { text: 'Catalog', path: '/catalog', exact: false }
  ];
}
