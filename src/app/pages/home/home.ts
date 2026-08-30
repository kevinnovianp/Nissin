import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  imports: [],
  selector: 'app-home',
  styleUrl: './home.scss',
  templateUrl: './home.html',
})
export class Home {
  private router = inject(Router);

  categories = [
    {"id": 1, "img": "Image.png", "desc": "Chiller & Freezer"},
    {"id": 2, "img": "Image.png", "desc": "Coffee Machine"},
    {"id": 3, "img": "Image.png", "desc": "Cooking Equipment"},
    {"id": 4, "img": "Image.png", "desc": "Dishwasher"},
    {"id": 5, "img": "Image.png", "desc": "Food Holding Preparation"},
    {"id": 6, "img": "Image.png", "desc": "Food Processing Equipment"},
    {"id": 7, "img": "Image.png", "desc": "Ice Machine"},
  ]

  chooseCategory(id: number) {
    this.router.navigate(['/products'], { queryParams: { category: id } });
  }
}
