import { Routes } from '@angular/router';
import { Home } from './pages/home/home';
import { AboutUs } from './pages/about-us/about-us';
import { Catalog } from './pages/catalog/catalog';
import { OurService } from './pages/our-service/our-service';
import { Products } from './pages/products/products';

export const routes: Routes = [
  { path: '', component: Home },
  { path: 'products', component: Products },
  { path: 'about-us', component: AboutUs },
  { path: 'our-service', component: OurService },
  { path: 'catalog', component: Catalog },
];
