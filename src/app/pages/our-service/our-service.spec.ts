import { ComponentFixture, TestBed } from '@angular/core/testing';
import { OurService } from './our-service';

describe('OurService', () => {
  let component: OurService;
  let fixture: ComponentFixture<OurService>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OurService],
    }).compileComponents();

    fixture = TestBed.createComponent(OurService);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
