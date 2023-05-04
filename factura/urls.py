from django.urls import path
from . import views

urlpatterns = [
    path('', views.inicio, name='index'),
    
    path('productos', views.productos, name='productos'),
    path('productos/crear-producto/', views.crear_producto, name='crear_producto'),

    path('clientes', views.clientes, name='clientes'),

    path('facturas', views.facturas, name='facturas'),
]