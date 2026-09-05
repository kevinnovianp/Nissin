import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class Catalog {
  private apiUrl = 'http://localhost/nissin-api';
  private http = inject(HttpClient);

  getCategories(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/categories`);
  }

  getProducts(categoryId?: number): Observable<any[]> {
    let url = `${this.apiUrl}/products`;
    if (categoryId) {
      url += `?category_id=${categoryId}`;
    }
    return this.http.get<any[]>(url);
  }

  getProductDetail(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/products/${id}`);
  }
}
