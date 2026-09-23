import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CatalogService {
  private apiUrl = 'http://localhost/nissin-api';
  readonly imgUrl = 'http://localhost/nissin-api/uploads/';

  private http = inject(HttpClient);

  // --- READ GET ---
  getCategories(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/categories`);
  }
  getCarousels(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/carousels`);
  }
  getProducts(categoryId?: number): Observable<any[]> {
    let url = `${this.apiUrl}/products`;
    if (categoryId) url += `?category_id=${categoryId}`;
    return this.http.get<any[]>(url);
  }
  getLatestProducts(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/products/latest`);
  }
  getProductDetail(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/products/${id}`);
  }

  // --- CREATE (POST) ---
  saveData(type: string, formData: FormData): Observable<any> {
    const endpoint = type === 'category' ? 'categories' : `${type}s`;
    return this.http.post(`${this.apiUrl}/${endpoint}`, formData);
  }

  // --- UPDATE (POST dengan parameter ID untuk mendukung form multipart gambar) ---
  updateData(type: string, id: number, formData: FormData): Observable<any> {
    const endpoint = type === 'category' ? 'categories' : `${type}s`;
    return this.http.post(`${this.apiUrl}/${endpoint}?id=${id}`, formData);
  }

  // --- DELETE (DELETE) ---
  deleteCarousel(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/carousels/${id}`);
  }
  deleteCategory(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/categories/${id}`);
  }
  deleteProduct(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/products/${id}`);
  }

  // --- GENERATE PDF ---
  downloadCatalog(): Observable<Blob> {
    return this.http.get(`${this.apiUrl}/generate-file`, {
      responseType: 'blob'
    });
  }
}
