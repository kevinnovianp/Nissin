import { Routes } from '@angular/router';
import { Home } from './pages/home/home';
import { AboutUs } from './pages/about-us/about-us';
import { Catalog } from './pages/catalog/catalog';
import { OurService } from './pages/our-service/our-service';
import { Products } from './pages/products/products';
import { Product } from './pages/product/product';
import { CatalogForm } from './pages/catalog-form/catalog-form';

export const routes: Routes = [
  { path: '', component: Home },
  { path: 'products', component: Products },
  { path: 'product', component: Product },
  { path: 'about-us', component: AboutUs },
  { path: 'our-service', component: OurService },
  { path: 'catalog', component: Catalog },
  { path: 'catalog-form/:type', component: CatalogForm },
  { path: 'catalog-form/:type/:id', component: CatalogForm }
];
