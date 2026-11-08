import { Routes } from '@angular/router';
import { Home } from './pages/home/home';
import { AboutUs } from './pages/about-us/about-us';
import { Products } from './pages/products/products';
import { Product } from './pages/product/product';

export const routes: Routes = [
  { path: '', component: Home },
  { path: 'products', component: Products },
  { path: 'product', component: Product },
  { path: 'about-us', component: AboutUs }
];
