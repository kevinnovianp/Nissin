export interface Category {
  id: number;
  img: string;
  desc: string;
}

export interface Product {
  id: number;
  img: string;
  name: string;
  model: string;
  category_id: number;
  desc_1: string;
  desc_2: string;
  intro_1: string;
  intro_2: string;
}

export interface ProductFeature {
  id: number;
  product_id: number;
  title: string;
  desc: string;
}

export interface ProductSpec {
  id: number;
  product_id: number;
  title: string;
  value: string;
}
