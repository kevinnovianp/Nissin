import { Component, inject } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { NavigationEnd, Router, RouterLink } from '@angular/router';
import { filter, map } from 'rxjs';

@Component({
  standalone: true,
  imports: [RouterLink],
  selector: 'app-header',
  styleUrl: './header.scss',
  templateUrl: './header.html',
})
export class Header {
  private router = inject(Router);

  currentUrl = toSignal(
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd),
      map((event: NavigationEnd) => event.urlAfterRedirects.split('?')[0])
    ),
    { initialValue: this.router.url.split('?')[0] }
  );

  navMenus = [
    { text: 'Home', path: '/', exact: true },
    { text: 'About Us', path: '/about-us', exact: false },
    { text: 'Products', path: '/products', exact: false },
    { text: 'Catalog', path: '/catalog', exact: false },
  ];

  isMenuRouteActive(menu: { path: string; exact: boolean }): boolean {
    const url = this.currentUrl();
    if (menu.path === '/products') return url.startsWith('/products') || url.startsWith('/product');
    return menu.exact ? url === menu.path : url.startsWith(menu.path);
  }
}
