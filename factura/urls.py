from django.urls import path
from . import views

urlpatterns = [
    path('', views.inicio, name='index'),
    
    # PRODUCTOS
    path('productos', views.productos, name='productos'),
    path('productos/crear-producto/', views.crear_producto, name='crear_producto'),
    
    
    
    # CLIENTES
    path('clientes', views.clientes, name='clientes'),
    
    
    
    # FACTURAS
    path('facturas', views.facturas, name='facturas'),
    path('facturas/crear-factura', views.crear_factura, name='crear-factura'),

]