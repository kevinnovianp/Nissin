import { ChangeDetectorRef, Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, switchMap } from 'rxjs';
import { Catalog } from '../../services/catalog';

@Component({
  imports: [],
  selector: 'app-products',
  styleUrl: './products.scss',
  templateUrl: './products.html',
})
export class Products implements OnInit, OnDestroy {
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  public catalogService = inject(Catalog);
  private cdr = inject(ChangeDetectorRef);
  private sub?: Subscription;

  products: any[] = [];
  filteredProducts: any[] = [];
  paginatedProducts: any[] = [];

  currentPage = 1;
  itemsPerPage = 8;
  totalPages = 0;
  pagesArray: (number | string)[] = [];

  ngOnInit() {
    this.sub = this.route.queryParamMap.pipe(
      switchMap(params => {
        let categoryId = params.get('category');
        this.currentPage = 1;

        if (categoryId) {
          console.log(`Mengambil produk untuk kategori ID: ${categoryId}`);
          return this.catalogService.getProducts(Number(categoryId));
        } else {
          console.log('Tidak ada query param, mengambil seluruh produk.');
          return this.catalogService.getProducts();
        }
      })
    ).subscribe({
      next: (data: any[]) => {
        this.products = data;

        // if (data.length > 0) {
        //   this.products = Array.from({ length: 65 }, (_, index) => {
        //     let tmp = data[0];
        //     return { ...tmp, id: index + 1, name: `${tmp.name} - ${index + 1}` };
        //   });
        // }
        this.filteredProducts = this.products;

        this.calculatePages();
        this.updatePaginatedProducts();
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Err: ', err);
      }
    });
  }

  ngOnDestroy() {
    this.sub?.unsubscribe();
  }

  calculatePages() {
    this.totalPages = Math.ceil(this.filteredProducts.length / this.itemsPerPage);
    const pages: (number | string)[] = [];
    const range = 1;

    for (let i = 1; i <= this.totalPages; i++) {
      if (
        i === 1 ||
        i === this.totalPages ||
        (i >= this.currentPage - range && i <= this.currentPage + range)
      ) {
        pages.push(i);
      }
      else if (pages[pages.length - 1] !== '...') {
        pages.push('...');
      }
    }

    this.pagesArray = pages;
  }

  updatePaginatedProducts() {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    this.paginatedProducts = this.filteredProducts.slice(startIndex, startIndex + this.itemsPerPage);
  }

  goToPage(page: number | string) {
    if (typeof page === 'number' && page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.calculatePages();
      this.updatePaginatedProducts();
      this.cdr.detectChanges();
    }
  }

  get startResultIndex(): number {
    return (this.currentPage - 1) * this.itemsPerPage + 1;
  }

  get endResultIndex(): number {
    const currentMax = this.currentPage * this.itemsPerPage;
    return currentMax > this.filteredProducts.length ? this.filteredProducts.length : currentMax;
  }

  chooseProduct(id: number) {
    this.router.navigate(['/product'], { queryParams: { id: id } });
  }
}
