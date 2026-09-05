import { ChangeDetectorRef, Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { Catalog } from '../../services/catalog';

@Component({
  imports: [],
  selector: 'app-product',
  styleUrl: './product.scss',
  templateUrl: './product.html',
})
export class Product implements OnInit, OnDestroy {
  private route = inject(ActivatedRoute);
  private catalogService = inject(Catalog);
  private cdr = inject(ChangeDetectorRef);
  private sub?: Subscription;

  id: number | null = null;
  product: any = null;

  ngOnInit() {
    this.sub = this.route.queryParamMap.subscribe(params => {
      let productId = params.get('id');
      this.loadProduct(Number(productId));
    });
  }

  loadProduct(id: number) {
    this.catalogService.getProductDetail(id).subscribe({
      next: (data: any) => {
        console.log(data)
        this.product = data;
        this.cdr.markForCheck();
      },
      error: (err) => {
        console.error('Err: ', err);
      }
    });

  }

  ngOnDestroy() {
    this.sub?.unsubscribe();
  }

}
