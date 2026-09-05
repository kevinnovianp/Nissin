import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { CatalogService } from '../../services/catalog';
import { FormsModule } from '@angular/forms';

@Component({
  imports: [CommonModule, RouterModule, FormsModule],
  selector: 'app-catalog-form',
  styleUrl: './catalog-form.scss',
  templateUrl: './catalog-form.html',
})
export class CatalogForm implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private catalogService = inject(CatalogService);

  type: string = '';
  id: number | null = null;
  isEdit: boolean = false;
  categoriesList = signal<any[]>([]);

  formData = signal<any>({
    title: '', desc: '',
    name: '', model: '', category_id: '', desc_1: '', desc_2: '', intro_1: '', intro_2: ''
  });
  selectedFile: File | null = null;
  features = signal<any[]>([]);
  specsMain = signal<any[]>([]);
  specsOther = signal<any[]>([]);

  ngOnInit() {
    this.type = this.route.snapshot.paramMap.get('type') || '';
    const idParam = this.route.snapshot.paramMap.get('id');

    if (this.type === 'product') {
      this.catalogService.getCategories().subscribe(res => this.categoriesList.set(res));
    }

    if (idParam) {
      this.id = +idParam;
      this.isEdit = true;
      this.loadExistingData();
    }
  }

  loadExistingData(): void {
    if (!this.id) return;

    if (this.type === 'carousel') {
      this.catalogService.getCarousels().subscribe(res => {
        const item = res.find(c => c.id == this.id);
        if (item) {
          this.formData.update(oldData => ({
            ...oldData,
            title: item.title
          }));
        }
      });
    } else if (this.type === 'category') {
      this.catalogService.getCategories().subscribe(res => {
        const item = res.find(c => c.id == this.id);
        if (item) {
          this.formData.update(oldData => ({
            ...oldData,
            desc: item.desc
          }));
        }
      });
    } else if (this.type === 'product') {
      this.catalogService.getProductDetail(this.id).subscribe(res => {
        this.formData.set({ ...res });
        if (res.features) this.features.set(res.features);
        if (res.specs_main) this.specsMain.set(res.specs_main);
        if (res.specs_other) this.specsOther.set(res.specs_other);
      });
    }
  }

  addFeature() {
    this.features.update(items => [...items, { title: '', desc: '' }]);
  }
  addSpecMain() {
    this.specsMain.update(items => [...items, { title: '', value: '' }]);
  }
  addSpecOther() {
    this.specsOther.update(items => [...items, { title: '', value: '' }]);
  }

  removeFeature(index: number) {
    this.features.update(items => items.filter((_, i) => i !== index));
  }
  removeSpecMain(index: number) {
    this.specsMain.update(items => items.filter((_, i) => i !== index));
  }
  removeSpecOther(index: number) {
    this.specsOther.update(items => items.filter((_, i) => i !== index));
  }

  onFileChange(event: any): void {
    if (event.target.files && event.target.files.length > 0) {
      this.selectedFile = event.target.files[0];
    }
  }

  onSave(): void {
    const payload = new FormData();
    if (this.selectedFile) payload.append('img', this.selectedFile);
    if (this.isEdit && this.id) payload.append('id', this.id.toString());

    const currentData = this.formData();

    if (this.type === 'product') {
      payload.append('name', currentData.name);
      payload.append('model', currentData.model);
      payload.append('category_id', currentData.category_id);
      payload.append('desc_1', currentData.desc_1 || '');
      payload.append('desc_2', currentData.desc_2 || '');
      payload.append('intro_1', currentData.intro_1 || '');
      payload.append('intro_2', currentData.intro_2 || '');
      payload.append('features', JSON.stringify(this.features()));
      payload.append('specs_main', JSON.stringify(this.specsMain()));
      payload.append('specs_other', JSON.stringify(this.specsOther()));
    } else {
      if (this.type === 'carousel') payload.append('title', currentData.title || '');
      if (this.type === 'category') payload.append('desc', currentData.desc || '');
    }

    if (this.isEdit && this.id) {
      this.catalogService.updateData(this.type, this.id, payload).subscribe(() => this.router.navigate(['/catalog']));
    } else {
      this.catalogService.saveData(this.type, payload).subscribe(() => this.router.navigate(['/catalog']));
    }
  }
}
