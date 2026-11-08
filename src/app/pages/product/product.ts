import { ChangeDetectorRef, Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { firstValueFrom, map, Subscription } from 'rxjs';
import { CatalogService } from '../../services/catalog';

@Component({
  imports: [],
  selector: 'app-product',
  styleUrl: './product.scss',
  templateUrl: './product.html',
})
export class Product implements OnInit, OnDestroy {
  private route = inject(ActivatedRoute);
  public catalogService = inject(CatalogService);
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

  async loadProduct(id: number) {
    this.product = await firstValueFrom(this.catalogService.getProductDetail(id).pipe(
      map((data: any) => ({
        ...data,
        img_src: this.catalogService.catalogUrl + '/products/' + data.img
      }))
    ));
    this.cdr.markForCheck();
  }

  ngOnDestroy() {
    this.sub?.unsubscribe();
  }

}
