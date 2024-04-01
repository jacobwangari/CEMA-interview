from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission


class Customer(AbstractUser):
    disease = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=15)

    def __str__(self):
        return self.username

class Medication(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    dosage = models.CharField(max_length=50)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    expiry_date = models.DateField()
    manufacturer = models.CharField(max_length=100)

class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    medications = models.ManyToManyField(Medication)
    order_date = models.DateTimeField(auto_now_add=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    PAYMENT_STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('completed', 'Completed'),
    ]
    payment_status = models.CharField(max_length=20, choices=PAYMENT_STATUS_CHOICES, default='pending')
    PAYMENT_METHOD_CHOICES = [
        ('immediate', 'Immediate Payment'),
        ('at_collection', 'Pay at Collection'),
    ]
    payment_method = models.CharField(max_length=20, choices=PAYMENT_METHOD_CHOICES)
    DELIVERY_METHOD_CHOICES = [
        ('pickup', 'Pickup at Facility'),
        ('delivery', 'Delivery'),
    ]
    delivery_method = models.CharField(max_length=20, choices=DELIVERY_METHOD_CHOICES)
    delivery_address = models.TextField(blank=True, null=True)
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('fulfilled', 'Fulfilled'),
    ]
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f"Order #{self.id} by {self.customer.username}"
