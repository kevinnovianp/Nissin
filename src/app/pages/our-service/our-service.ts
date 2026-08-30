import { Component } from '@angular/core';

@Component({
  imports: [],
  selector: 'app-our-service',
  styleUrl: './our-service.scss',
  templateUrl: './our-service.html',
})
export class OurService {
  services: string[] = [
    'Consultation and Needs Assessment',
    'Custom Design and Engineering',
    'Installation and Commissioning',
    'Maintenance and Repair Services',
    'Energy Efficiency Solutions',
    '24/7 Emergency Support'
  ];
}
