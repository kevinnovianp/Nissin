import { ChangeDetectorRef, Component, inject, OnInit } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { CatalogService } from '../../services/catalog';
import { map, firstValueFrom  } from 'rxjs';

@Component({
  imports: [RouterLink],
  selector: 'app-home',
  styleUrl: './home.scss',
  templateUrl: './home.html',
})
export class Home implements OnInit {
  private router = inject(Router);
  private cdr = inject(ChangeDetectorRef);
  public catalogService = inject(CatalogService);

  carousels: any[] = [];
  categories :any[] = [];
  latestProducts : any[] = [];

  async ngOnInit() {
    try{
      this.carousels = await firstValueFrom(this.catalogService.getCarousels());

      this.categories = await firstValueFrom(this.catalogService.getCategories().pipe(
        map((data: any[]) => data.map(category => ({
          ...category,
          img_src: this.catalogService.catalogUrl + '/categories/' + category.img
        })))
      ));

      this.latestProducts = await firstValueFrom(this.catalogService.getLatestProducts(5).pipe(
        map((data: any[]) => data.map(product => {
          const category = this.categories.find(c => c.id === product.category_id);
          return {
            ...product,
            category_name: category.desc
          };
        }))
      ));
      this.cdr.markForCheck();

    } catch (err) {
      console.error('Terjadi kesalahan saat memuat data: ', err);
    }
  }

  chooseCategory(id: number) {
    this.router.navigate(['/products'], { queryParams: { category: id } });
  }

  chooseProduct(id: number) {
    this.router.navigate(['/product'], { queryParams: { id: id } });
  }
}
