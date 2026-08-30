import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  imports: [],
  selector: 'app-product',
  styleUrl: './product.scss',
  templateUrl: './product.html',
})
export class Product implements OnInit, OnDestroy {
  private route = inject(ActivatedRoute);
  private sub?: Subscription;

  id: number | null = null;
  product: any = null;

  ngOnInit() {
    this.sub = this.route.queryParamMap.subscribe(params => {
      let keys = params.keys;
      if(keys.length > 0 && keys.includes('id')) {
        this.id = Number(params.get('id'));
        this.loadProduct();
      }
    });
  }

  loadProduct() {
    this.product = {
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
  }

  ngOnDestroy() {
    this.sub?.unsubscribe();
  }

}
