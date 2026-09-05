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
  private catalogService = inject(Catalog);

  categories :any[] = [];

  ngOnInit() {
    this.catalogService.getCategories().pipe(
      map((data: any[]) => {
        return data;
      })
    ).subscribe({
      next: (data: any[]) => {
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
