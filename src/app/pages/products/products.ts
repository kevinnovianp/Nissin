import { Component, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  imports: [],
  selector: 'app-products',
  styleUrl: './products.scss',
  templateUrl: './products.html',
})
export class Products {
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private sub?: Subscription;

  products = [
    {
      "id": 1,
      "img": "Image.png",
      "name": "Nissin NSN-BD-550",
      "model": "NSN-BD-550",
      "category_id": 1,
      "desc_1": "Chest Freezer 465 Liter untuk kebutuhan commercial kitchen.",
      "desc_2": "Kapasitas 465 liter dengan temperatur ± -18°C hingga -25°C untuk kebutuhan penyimpanan produk beku.",
      "intro_1": "Dirancang untuk Kebutuhan Penyimpanan Frozen Food",
      "intro_2": "NISSIN NSN-BD-550 adalah chest freezer berkapasitas 465 liter dengan sistem compressor cooling system, dirancang untuk menjaga suhu penyimpanan pada rentang -18°C ~ -25°C. Cocok digunakan pada operasional dapur komersial yang membutuhkan ruang penyimpanan beku yang stabil dan konsisten.",
      "specs_main":[
        {"title":"Capacity", "value":"465 Liter"},
        {"title":"Temperature Range", "value":"-18°C to -25°C"},
        {"title":"Power", "value":"220V 1PH"},
        {"title":"Power output", "value":"180W"},
        {"title":"Dimension", "value":"1.530 x 600 x 850 mm"},
      ],
      "specs_other":[
        {"title":"Cooling System", "value":"Compressor Cooling System"},
        {"title":"Basket", "value":"White Wire / 1"},
        {"title":"Defrosting", "value":"Manual"},
        {"title":"Defrost Drain", "value":"Yes"},
        {"title":"Thickness", "value":"70 mm"},
      ],
      "features":[
        {"title":"Compressor Cooling System", "desc":"Sistem pendinginan menggunakan compressor untuk menjaga suhu penyimpanan."},
        {"title":"Manual Defrosting", "desc":"Proses pencairan bunga es dilakukan secara manual."},
        {"title": "70 mm Lid", "desc": "Ketebalan tutup 70 mm untuk menjaga insulasi suhu di dalam unit."},
        {"title":"White Wire Basket", "desc":"Dilengkapi 1 keranjang kawat putih untuk mempermudah penyimpanan."},
        {"title":"Defrost Drain", "desc":"Terdapat saluran pembuangan untuk air hasil pencairan bunga es."},
      ]
    }
  ]

  filteredProducts: any[] = [];
  paginatedProducts: any[] = [];

  currentPage = 1;
  itemsPerPage = 8;
  totalPages = 0;
  pagesArray: (number | string)[] = [];

  ngOnInit() {
    this.products = Array.from({ length: 65 }, (_, index) => {
      let tmp = this.products[0];
      return { ...tmp, id: index+1, name: `${tmp.name} - ${index + 1}`};
    });

    this.sub = this.route.queryParamMap.subscribe(params => {
      let keys = params.keys;
      this.currentPage = 1;

      if (keys.length > 0) {
        keys.forEach(key => {
          let value = params.get(key);
          console.log(`Key: ${key}, Value: ${value}`);
          this.filteredProducts = this.products.filter(product => product.category_id === Number(value));
        });
      } else {
        console.log('Tidak ada query param di URL.');
        this.filteredProducts = this.products;
      }

      this.calculatePages();
      this.updatePaginatedProducts();
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
