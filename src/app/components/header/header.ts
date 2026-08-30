import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  standalone: true,
  imports: [RouterLink],
  selector: 'app-header',
  styleUrl: './header.scss',
  templateUrl: './header.html',
})
export class Header {
  private router = inject(Router);

  navMenus = [
    { text: 'Home', path: '/', exact: true },
    { text: 'About Us', path: '/about-us', exact: false },
    { text: 'Products', path: '/products', exact: false },
    { text: 'Our Service', path: '/our-service', exact: false },
  ];

  isMenuRouteActive(menu: { path: string; exact: boolean }): boolean {
    const currentPath = this.router.url.split('?')[0];
    if (menu.path === '/products') return currentPath.startsWith('/products') || currentPath.startsWith('/product');
    return menu.exact ? currentPath === menu.path : currentPath.startsWith(menu.path);

  }
}
