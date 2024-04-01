from django.urls import path
from .views import customer_list, customer_detail, medication_list, order_detail,UserRegistrationView, UserLoginView


urlpatterns = [
    path('register/', UserRegistrationView.as_view(), name='user-registration'),
    path('login/', UserLoginView.as_view(), name='user-login'),
    path('customers/', customer_list, name='customer-list'),
    path('customers/<int:pk>/', customer_detail, name='customer-detail'),
    path('medications/', medication_list, name='medication-list'),
    path('orders/<int:pk>/', order_detail, name='order-detail'),
]
