from django.urls import path
from . import views

urlpatterns = [
    path('', views.inicio, name='index'),
    
    # PRODUCTOS
    path('productos', views.productos, name='productos'),
    path('productos/crear-producto/', views.crear_producto, name='crear_producto'),
    path('productos/editar-producto', views.editar_producto, name='editar_producto'),
    path('productos/editar-producto/<str:id>', views.editar_producto, name='editar_producto'),       
    path('productos/eliminar/<str:id>', views.eliminar_producto, name='eliminar_producto'),
    
    
    # CLIENTES
    path('clientes', views.clientes, name='clientes'),
    path('clientes/crear-cliente', views.crear_cliente, name='crear-cliente'),
    
    
    
    # FACTURAS
    path('facturas', views.facturas, name='facturas'),
    path('facturas/crear-factura', views.crear_factura, name='crear_factura'),
    path('facturas/crear-detalle', views.crear_detalle, name='crear_detalle'),
    path('facturas/eliminar/<str:id>', views.eliminar_facturas, name='eliminar_facturas'),


]