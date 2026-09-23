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
      const carouselsData = await firstValueFrom(
        this.catalogService.getCarousels().pipe(
          map((data: any[]) =>
            data.map(carousel => ({
              ...carousel,
              img_src: this.catalogService.imgUrl + 'carousels/' + carousel.img
            }))
          )
        )
      );
      this.carousels = carouselsData;
      this.cdr.markForCheck();

      const categoriesData = await firstValueFrom(
        this.catalogService.getCategories().pipe(
          map((data: any[]) =>
            data.map(category => ({
              ...category,
              img_src: this.catalogService.imgUrl + 'categories/' + category.img
            }))
          )
        )
      );
      this.categories = categoriesData;
      this.cdr.markForCheck();

      const productsData = await firstValueFrom(this.catalogService.getLatestProducts());
      this.latestProducts = productsData.map(product => {
        const category = this.categories.find(c => c.id === product.category_id);
        return {
          ...product,
          category_name: category.desc
        };
      });
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
