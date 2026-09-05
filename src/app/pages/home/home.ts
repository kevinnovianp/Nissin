import { ChangeDetectorRef, Component, inject, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Catalog } from '../../services/catalog';
import { map, Observable } from 'rxjs';

@Component({
  imports: [],
  selector: 'app-home',
  styleUrl: './home.scss',
  templateUrl: './home.html',
})
export class Home implements OnInit {
  private router = inject(Router);
  private cdr = inject(ChangeDetectorRef);
  public catalogService = inject(Catalog);

  carousels: any[] = [];
  categories :any[] = [];

  ngOnInit() {
    this.catalogService.getCarousels().pipe(
      map((data: any[]) => {
        return data.map(carousel => ({
          ...carousel,
          img_src: carousel.img.startsWith('http') ? carousel.img : this.catalogService.imgUrl + 'carousels/' + carousel.img
        }));
      })
    )
    .subscribe({
      next: (data: any[]) => {
        this.carousels = data;
        this.cdr.markForCheck();
      },
      error: (err) => {
        console.error('Err: ', err);
      }
    });

    this.catalogService.getCategories().pipe(
      map((data: any[]) => {
        return data.map(category => ({...category,
          img_src: category.img.startsWith('http') ? category.img : this.catalogService.imgUrl + 'categories/' + category.img
        }));
      })
    ).subscribe({
      next: (data: any[]) => {
        console.log(data)
        this.categories = data;
        this.cdr.markForCheck();
      },
      error: (err) => {
        console.error('Err: ', err);
      }
    });
  }

  chooseCategory(id: number) {
    this.router.navigate(['/products'], { queryParams: { category: id } });
  }
}
