from rest_framework import serializers
from .models import Customer, Medication, Order

class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ['id', 'username', 'email', 'disease', 'phone_number']

class MedicationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Medication
        fields = ['id', 'name', 'description', 'dosage', 'quantity', 'price', 'expiry_date', 'manufacturer']

class OrderSerializer(serializers.ModelSerializer):
    customer = CustomerSerializer()
    medications = MedicationSerializer(many=True)

    class Meta:
        model = Order
        fields = ['id', 'customer', 'medications', 'order_date', 'total_amount', 'payment_status', 'payment_method', 'delivery_method', 'delivery_address', 'status']
