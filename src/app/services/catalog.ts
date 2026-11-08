import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { forkJoin, Observable } from 'rxjs';
import { environment } from '../../environments/environment';
import { map } from 'rxjs/operators';
import { Category, Product, ProductFeature, ProductSpec } from '../models/catalog.model';

@Injectable({
  providedIn: 'root'
})
export class CatalogService {
  private apiUrl = environment.apiUrl;
  readonly carouselUrl = 'images/carousels';
  readonly catalogUrl = 'images/catalogs';

  private http = inject(HttpClient);

  getCarousels(): Observable<string[]> {
    return this.http.get<string[]>(`${this.carouselUrl}/images.json`).pipe(
      map(fileNames => fileNames.map(name => `${this.carouselUrl}/${name}`))
    );
  }

  getCategories(): Observable<Category[]> {
    return this.http.get<Category[]>(`${this.catalogUrl}/categories.json`);
  }

  getProducts(): Observable<Product[]> {
    return this.http.get<Product[]>(`${this.catalogUrl}/products.json`);
  }

  getLatestProducts(limit: number = 5): Observable<Product[]> {
    return this.getProducts().pipe(
      map((products: Product[]) => {
        return [...products]
          .sort((a, b) => b.id - a.id)
          .slice(0, limit);
      })
    );
  }

  getProductsByCategory(categoryId: number): Observable<Product[]> {
    return this.getProducts().pipe(
      map((products: Product[]) => {
        return products.filter(product => product.category_id === categoryId);
      })
    );
  }

  getProductDetail(productId: number): Observable<any> {
    return forkJoin({
      products: this.http.get<Product[]>(`${this.catalogUrl}/products.json`),
      features: this.http.get<ProductFeature[]>(`${this.catalogUrl}/product_features.json`),
      specsMain: this.http.get<ProductSpec[]>(`${this.catalogUrl}/product_specs_main.json`),
      specsOther: this.http.get<ProductSpec[]>(`${this.catalogUrl}/product_specs_other.json`)
    }).pipe(
      map(res => {
        const product = res.products.find(p => p.id === productId);
        if (!product) throw new Error('Product not found');

        return {
          ...product,
          features: res.features.filter(f => f.product_id === productId),
          specs_main: res.specsMain.filter(s => s.product_id === productId),
          specs_other: res.specsOther.filter(s => s.product_id === productId)
        };
      })
    );
  }
}
