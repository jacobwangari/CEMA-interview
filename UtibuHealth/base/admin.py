from django.contrib import admin
from .models import Customer, Medication, Order

class ManagerSite(admin.AdminSite):
    site_header = 'Utibu Health System'
    site_title = 'Utibu Health System'
    index_title = 'Utibu Health System'
  


manager_site = ManagerSite(name='Utibu Health System')

@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'disease', 'phone_number')
    search_fields = ('username', 'email', 'disease')

@admin.register(Medication)
class MedicationAdmin(admin.ModelAdmin):
    list_display = ('name', 'description', 'dosage', 'quantity', 'price', 'expiry_date', 'manufacturer')
    search_fields = ('name', 'manufacturer')
    list_filter = ('expiry_date',)

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('customer', 'order_date', 'total_amount', 'payment_status', 'delivery_method', 'status')
    search_fields = ('customer__username', 'customer__email')
    list_filter = ('order_date', 'payment_status', 'status')
