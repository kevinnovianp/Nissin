import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { CatalogService } from '../../services/catalog';
import { map } from 'rxjs';

@Component({
  imports: [CommonModule, RouterModule],
  selector: 'app-catalog',
  styleUrl: './catalog.scss',
  templateUrl: './catalog.html',
})
export class Catalog implements OnInit {
  private catalogService = inject(CatalogService);
  private router = inject(Router);

  carousels = signal<any[]>([]);
  categories = signal<any[]>([]);

  ngOnInit() {
    this.loadData();
  }

  loadData(): void {
    this.catalogService.getCarousels().pipe(
      map((data: any[]) => {
        return data.map(carousel => {
          return {
            ...carousel,
            img_src: this.catalogService.imgUrl + 'carousels/' + carousel.img
          };
        });
      })
    ).subscribe(data => this.carousels.set(data));

    this.catalogService.getCategories().pipe(
      map((data: any[]) => {
        return data.map(category => {
          return {
            ...category,
            img_src: this.catalogService.imgUrl + 'categories/' + category.img
          };
        });
      })
    ).subscribe(data => {
      this.categories.set(data);
      data.forEach(cat => this.loadProductsForCategory(cat.id));
    });
  }

  loadProductsForCategory(catId: number): void {
    this.catalogService.getProducts(catId).subscribe(data => {
      let tempProducts :any[] = data.map(product => ({
        ...product,
        img_src: this.catalogService.imgUrl + 'products/' + product.img
      }));
      this.categories.update(cats =>
        cats.map(c => c.id === catId ? { ...c, products: tempProducts } : c)
      );
    });
  }

  navigateToAdd(type: string) {
    this.router.navigate(['/catalog-form', type]);
  }

  navigateToUpdate(type: string, id: number) {
    this.router.navigate(['/catalog-form', type, id]);
  }

  deleteCarousel(id: number) {
    if (confirm('Are you sure you want to delete this carousel?')) {
      this.catalogService.deleteCarousel(id).subscribe(() => this.loadData());
    }
  }

  deleteCategory(category: any) {
    if (category.products && category.products.length > 0) {
      alert(`Failed to delete! Category "${category.desc}" still has ${category.products.length} products in it. Please delete the products first.`);
      return;
    }

    if (confirm(`Are you sure you want to delete the category "${category.desc}"?`)) {
      this.catalogService.deleteCategory(category.id).subscribe(() => this.loadData());
    }
  }

  deleteProduct(id: number) {
    if (confirm('Are you sure you want to delete this product?')) {
      this.catalogService.deleteProduct(id).subscribe(() => this.loadData());
    }
  }

  exportCatalog(): void {
    const currentData = this.categories();

    if (currentData.length === 0) {
      alert("No available data for export!");
      return;
    }

    this.catalogService.downloadCatalog().subscribe({
      next: (responseBlob: Blob) => {
        const cleanTxtBlob = new Blob([responseBlob], { type: 'text/plain;charset=utf-8' });
        const blobUrl = window.URL.createObjectURL(cleanTxtBlob);

        const link = document.createElement('a');
        link.href = blobUrl;
        link.download = 'ringkasan-katalog-produk.txt'; // Simpan sebagai berkas .txt

        document.body.appendChild(link);
        link.click();

        document.body.removeChild(link);
        window.URL.revokeObjectURL(blobUrl);
      },
      error: (err) => {
        console.error("Err: ", err);
        alert("There is an internal issue with the XAMPP server while processing the text catalog file!");
      }
    });
  }
}
